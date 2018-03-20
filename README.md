# Basic Noise Reduction
Basic Noise Reduction of 2 samples given in [Test File](https://github.com/AkhilChilakala/Basic-Noise-Reduction/blob/master/SCONES_test.tsv)

Since only **basic reduction** is required and No excess data is given, **Data Cleaning** (Outlier Removal) followed by a **SimpleMovingAverage method** is used on the time series data individually, Although it doesn't fully remove the noise, but with a small k (roll width) value it's a good filtering method to remove random fluctuations.<br>

**Suggested Techniques:**<br>
**Adaptive Filters** or **Neural Networks** these are very efficient but more data is required to feed into these models,<br>
If less data is available Weiner Filter (linear Adaptive Filter theory) or any other clustering techniques can be used.<br><br>
The following results are obtained through [code.R](https://github.com/AkhilChilakala/Basic-Noise-Reduction/blob/master/code.R) by using [these](https://github.com/AkhilChilakala/Basic-Noise-Reduction/blob/master/Libraries%20Used) R packages.<br><br>
![Final](/Plots/Final.png)
<br><br>
**Sample 1 Original**  <br>                       
![Sample1original](/Plots/Sample1.png) <br><br>
**Sample1 filtered data** <br><br>
![Sample1filtered](/Plots/Sample1Filtered.png) <br>
**Sample 2 Original** <br>                       
![Sample2original](/Plots/Sample2.png) <br>
**Sample2 filtered data** <br><br>
![Sample2filtered](/Plots/Sample2Filtered.png) 
