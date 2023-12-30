# Day 1: Trebuchet
<style>
.markdown-body pre.dark {
  background-color: black;
  color: #ddd;
}
.markdown-body pre.dark b { color: white; }
</style>

Combine numbers found in strings, sum them

## Part 1

* For each line of input:
  - Take the first and last digit from a string
  - Combine them to form a two-digit number
* Return the sum of each two digit number

#### Example

<pre class="dark">
vvk<b>5</b>i9ga<b>2</b>f
hlchquzq<b>51</b>
f<b>4</b>4if7p<b>0</b>wo
</pre>

On the first line we will combine the digits 5 and 2 to make 52. On the next lines, 51, and then 40.
The return value will be treating the strings we've just stitched together as actual numbers, adding
them together to make:

    52 + 51 + 40 = 143

### Edge case

* A line might only have one digit

<pre class="dark">
v<b>1</b>0rni<b>4</b>seb
kwrecwjo<b>2</b>o
<b>4</b>9n8tsuio<b>4</b>
</pre>

On the second line, 2 is both the first and last digit, so combining the first and last digit gives us 22, and we return:

    14 + 22 + 44 = 80

## Part 2

Same as part 1, but also include numbers that are spelled out as words.

<pre class="dark">
<b>3</b>fisixug<b>1</b>r
rzxmcf<b>2</b>ek<b>4</b>
<b>0</b>g<b>five</b>ecyh
</pre>

Here we'll change our thinking of "digit" to mean an Arabic numeral or a number word. The top line
gives us 31. The number word "six" is in the line, but it is not the first or last digit. The second
line has no number words, so that gives us 24. On the last line, the number word "five" comes after
any other digits, so we convert that to "5" and build "05"... or just 5.

    31 + 24 + 5 = 60

### Edge case

<details>
  <summary>Here be spoilers!</summary>

* Number words may be substrings of each other

<pre class="dark">
s<b>seven</b>inewbmpas76l<b>5</b>b
<b>4</b>qfsixh3p53nin<b>eighth</b>
<b>5</b>xtxxp9jpyt8sfvu<b>6</b>xqs
</pre>

This gives us "seven" and "5" from the first row, "4" and "eight" from the middle row, and "5" and
"6" from the last. Converting those to numbers and combining them gives 75, 48, and 56 for...

    75 + 48 + 56 = 179

There are nine combinations of number words where the last letter of one word is the first letter of the next:

* zerone
* twone
* eightwo
* eighthree
* oneight
* threeight
* fiveight
* nineight
* sevenine

I believe each user's dataset will contain a sprinkling of these, at least one of which will be the
last digit on a line (under the assumption that Eric wants to ensure all working solutions work for
all datasets).

This poses a problem depending on how you're searching for these number words. The naive approach using regular expressions would be:

    /(\d|zero|one|two|three|four|five|six|seven|eight|nine)/g

...and then take the first and last entry of the resulting list. The problem here is that the above
regex applied to `1eightwo` will return the list

    ["1", "eight"]

and not

    ["1", "eight", "two"]

...due to the way regex position markers work.

My solve for this used a combo of empty string
match, lookahead assertions, and capture groups. I'm happy with it, and it reads well to me, but in
general I like writing code that novices can follow without much effort. In this case, unless you
live and breathe regular expressions, it's going to be hard to decipher what my regex is doing.

If you aren't a regex nerd, a perfectly valid solve for part 2 is to iterate over a list of number
words and search for their indices in each line of the dataset with something like...

```ruby
l_idx, r_idx = [:index, :rindex].map { |cmd| line.send(cmd, number_word) }
```

...then find the mins and maxes and what digits they correspond to. A bit more verbose, which is
fine, but regular expressions are a great tool and worth the investment to learn.
</details>
