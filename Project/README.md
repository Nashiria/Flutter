
# Predizione

Match prediction app.

## Report

## 1-	Identification of Problem/Purpose of the Software:

The global sports betting industry has market size more than 200 billion U.S. dollars in 2020. There are approximately 30.000 bettings businesses which employs more than 200.000 people. These people work to predict results and set the odds accordingly. These predictions depends on the current form of the teams, morale of the players and other various factors. In 2020 season, considering lowest return is the predictor’s prediction for result, betting companies has %52.63 accuracy on results of the Premier Leauge. This accuracy is still enough for the profit but with more accuracy it can be more profitable. Purpose of this software is to achieve these predictions without spending any human resources. Currently Predizione starts predicting after first 5 matches and has %50.87 accuracy predicting the result with makes 2 match difference from the company predicitions, %33.33 predicting the home score and %33.33 predicting the away score of the Premier League matches. Currently for legal reasons, I desinged a fake league containing fake teams with real results from a real league to check accuracy ratios.

## 2-	Solution of the Problem / Solution Design

### a)	Which datas are needed for these predictions?

Currently, Predizione uses fixtures and results of the past matches on that season. In addition to that, it uses average bet odd rates for draw matches and optionally it can use forms of the any team from any league to match the matching teams form with past data.

### b)	How these datas are being inserted to the software?

Originally, Predizione uses MySQL database for the data inputs. But for testing reasons, I implemented these data files inside Predizione because my MySQL server is not reachable from outside my computer. 

###  Algorithm Structure
1.	Database class gets the data from the MySQL server.
2.	Predizione predicts the results from the data.
3.	UI generates modules from this data.


## 3- Testing of the Results
Accuracy Ratios from bet companies and Predizione:

| League Name |	Bet company |	Predizione |
|---|---|---|
|Premier League|	%52.09|	%50.87|
|English Championship|	%44.67|	%45.69|
|English League 1|	%48.79|	%45.29|
|English League 2|	%44.18|	%45.0|
|English Conference|	%51.61|	%53.76|
|Scottish Premiership|	%56.41|	%52.63|
|Scottish Championship|	%50.0|	%60.0|
|Bundesliga|	%48.53|	%53.75|
|Bundesliga 2|	%50.0|	%52.5|
|La Liga|	%50.73|	%52.88|
|La Liga 2|	%47.51|	%47.51|
|Serie A|	%55.5|	%49.49|
|Serie B|	%40.5|	%48.48|
|Ligue 1|	%51.98|	%50.79|
|Ligue 2|	%47.65|	%50.0|
|Belgian Pro League|	%46.66|	%44.77|
|Eredivisie|	%55.0|	%49.43|
|Liga NOS|	%57.82|	%53.57|
|Superlig|	%46.77|	%50.80|
|Super League 1|	%52.17|	%49.25|


## Screenshots:
![](https://github.com/Nashiria/Flutter/blob/main/Project/screenshots/screenshot1.PNG)
![](https://github.com/Nashiria/Flutter/blob/main/Project/screenshots/screenshot2.PNG)
![](https://github.com/Nashiria/Flutter/blob/main/Project/screenshots/screenshot3.PNG)
![](https://github.com/Nashiria/Flutter/blob/main/Project/screenshots/screenshot4.PNG)

