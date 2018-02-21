proposal
================
Rachel Ramirez
2018-02-21

<!-- dont edit the MarkDown file, edit the RMarkdown file anad then knit -->
[![Build Status](https://travis-ci.org/rachelramirez/NPS.svg?branch=master)](https://travis-ci.org/rachelramirez/NPS) [![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/rachelramirez/NPS?branch=master&svg=true)](https://ci.appveyor.com/project/rachelramirez/NPS) <!-- [![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/NPS)](http://cran.r-project.org/package=NPS) --> [![Coverage Status](https://codecov.io/gh/rachelramirez/NPS/branch/master/graph/badge.svg)](https://codecov.io/gh/rachelramirez/NPS?branch=master)

Explore NPS Acoustic Summary Data Analytic Proposal
---------------------------------------------------

### Section 1: Basic information about the analytic data product

-   1.1 Provide a short name (either a single word or an acronym) for the analytic you plan to develop. **NPS** National Park Service (NPS) acoustic summary data

-   1.2 Provide a brief title (1-2 sentences) describing – at the 50,000-foot level – what your analytic does. Your title should be short and to the point, but should also be clear to an end user: **Interactive Visualizer for National Park Service Acoustic Summary Data**

-   1.3 Provide a description (2-3 paragraphs) of why this analytic data product will be useful for an end-user. This description should address the following points (where applicable): **There are many variables in the National Park Service acoustic summary data, thus many ways to do exploratory data analysis or visual analysis. Even if an end-user owns JMP or is an expert programmer, taking time to code and visualize all the different ways to view the variables will take a long time and the time spent coding is wasted when one can be easily manipulating the data interactively.**
    -   1.3.A Describe each of the features that your analytic will perform when complete: **The “NPS” package/Shiny app will allow a novice to start tinkering with the dataset by location, season, specifying the amount of land type, the distance to different features, and incorporate acoustic summary data like frequencies, decibels, and equivalency acoustics.**
    -   1.3.B Describe the typical end-user for whom this analytic is being developed: **The typical end-user is anyone interested in viewing the acoustic summary data of the National Park Service.**
    -   1.3.C Describe any specific knowledge/skills/abilities an end-user must have to use your analytic: **The end user does not need to have any specific knowledge/skills/abilities, but a basic understanding of acoustic terms and geospatial variables may help.**
    -   1.3.D If your analytic implements known statistical methods, specify them: **The analytic is mostly visual and will not likely implement any statistical techniques. **
    -   1.3.E If your analytic builds on existing statistical methods or R packages, specify them: **The NPS analytic may need ggplot2, and different interactive visual packages such as map packages.**
-   1.4 How will end-users access your analytic data product? **End-users will access the NPS analytic via github or public webpage.**

-   1.5 Are there any security concerns that need to be addressed? **No security concerns need to be addressed.**

-   1.6 Are there any appearance/design constraints that your analytic must adhere to? **There are no known appearance or design constraints, however it would be nice if the data-analytic could adhere to the color-guidelines given in National Land Cover database for Land Cover Land Use Category Indicators. Those colors are provided by Red-Green-Blue schemes that may help an end-user visualize geographical data more easily.**

### Section 2: Delivery and schedule information

-   2.1 Review the features you listed in Section 1.3.A. Construct a table with the following information
    -   2.1.A. The description of the feature
    -   2.1.B. A rank ordered priority number for this feature
    -   2.1.C. The status of the feature – should be either ‘finished’, ‘in-work’, or ‘not started’
    -   2.1.D. What value will this feature provide to an end-user?
    -   2.1.E. What input(s) must be provided by end-user to perform this feature?
    -   2.1.F. What output(s) will this feature return to the end-user?
    -   2.1.G. What do you envision an end-user will do with the output of this feature?
    -   2.1.H. Is there sufficient time to deliver this feature prior to the deadline?
    -   2.1.I. Does this feature need to be included in the current version of your analytic or can it be pushed to a future update?

<table>
<colgroup>
<col width="3%" />
<col width="31%" />
<col width="48%" />
<col width="18%" />
</colgroup>
<thead>
<tr class="header">
<th>Priority<sup>(2.1.B)</sup></th>
<th>Feature Description<sup>(2.1.A)</sup></th>
<th>Value<sup>(2.1.D)</sup> and goal with output<sup>(2.1.G)</sup></th>
<th>Status<sup>(2.1.C)</sup></th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td>1</td>
<td>Interaction between siteIDs and Frequencies. Inputs<sup>(2.1.E)</sup>: Pick one of ~400 siteIDs. Outputs<sup>(2.1.F)</sup>: Chart with all 1/3 octave band freqs.</td>
<td>The ability to visualize ~500 acoustic profiles. End-user may not do anything with the output.</td>
<td>Not started. Goal: 24 Jan</td>
</tr>
<tr class="even">
<td>2</td>
<td>Interaction between parks and Frequencies. Inputs: Pick one of the ~70 parks with multiple observations. Outputs: Chart 1/3 octave band freqs</td>
<td>Visualize ~70 different acoustic profiles with each siteID. An end-user may not do anything with the output of this feature.</td>
<td>Not started. Goal: 31 Jan</td>
</tr>
<tr class="odd">
<td>3</td>
<td>Interaction between siteIDs and Hours. Inputs: Pick one of ~400 siteIDs. Outputs: Chart all 1/3 octave band freqs</td>
<td>Visualize ~500 different acoustic profiles by time. End-user may not do anything with output</td>
<td>Not started. Goal: 7 Feb</td>
</tr>
<tr class="even">
<td>4</td>
<td>Visualize Frequency data and L90dBA overlay. Inputs: Pick one of the parks/siteIDs. Outputs: Chart 1/3 octaveband freqs with overlay of L90, L50, L10 decibels.</td>
<td>Visualize impact of different octave band frequencies on loudness. End-user may not do anything with output.</td>
<td>Not started: Goal: 14 Feb</td>
</tr>
<tr class="odd">
<td>5</td>
<td>Ability to grab and drop or specify multiple x’s and multiple y’s for boxplots or scatterplots. Inputs: Pick x and pick y from chart-axis. Outputs: Chart of y versus x</td>
<td>Visualize the impact of certain geospatial variables on sound. An end-user may want to copy a picture of this chart.</td>
<td>Not started. Goal: 21 Feb</td>
</tr>
<tr class="even">
<td>6</td>
<td>Ability to interact with points on the plots, to find out more information about potential outliers. Inputs: click on a point on a graph. Outputs: more meta-data on the point in the graph like siteID, Season, year, hours, Lat/Long, park name, visual of a map, etc.</td>
<td>Visualize geospatial variables on sound. An end-user may want to copy a picture of this chart.</td>
<td>Not started. Goal: 28 Feb</td>
</tr>
<tr class="odd">
<td>7</td>
<td>Ability to select different amount of data and see multiple graphs at once. Inputs: different levels of different variables. Output: multiple plots that can hilight the same point in each plot</td>
<td>The ability to visualize where an outlier or point of interest is in respective to all the other data. An end user may use this to understand outliers better.</td>
<td>Not enough time</td>
</tr>
<tr class="even">
<td>8</td>
<td>Inputs: give a bunch of data on each x-variables. Output: predict the nearest–matching observation in the dataset</td>
<td>An end user may use this to guess what an point of interest’s acoustic profile may sound like, or best replicate a sound profile with different characteristics of interest, like frequency or loudness by hours of day.</td>
<td>Not enough time</td>
</tr>
<tr class="odd">
<td>9</td>
<td>Run random-forests on the dataset Input: select the data for training and testing, select some tunable hyperparameters of interest Output: Prediction Accuracy</td>
<td>An end user may use this to predict a characterization algorithm.</td>
<td>Not enough time</td>
</tr>
</tbody>
</table>
