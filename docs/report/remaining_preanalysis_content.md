
### Data collection and spatial sampling

The original study included over 70 qualitative semi-structured interviews with officials from development agencies, government, and non-governmental organizations (1.4).
47 specific interviewee titles are listed in a "full list of the interviews" (A1), leaving uncertainty around the remaining 23 (or more) interviewees.
The study included 11 village focus groups (1.4).
The interviews and focus groups were selected to focus on villages and organizations connected at different levels of organization to "externally designed adaptation projects" (3.2).
We presume that the interviewees and focus groups were selected based upon their association with externally designed and funded climate change adaptation projects, which are neither equally nor justly distributed (Barrett 2014).
No minimum sample size or stopping criteria were defined.

The original authors used exclusively secondary data for the vulnerability models and did not subset or sample from the secondary data.
The published results based on DHS surveys include data 203 traditional authorities in 2010 (F4), whereas the authors state that there are more than 250 populated traditional authorities in Malawi (4.4).
The 2010 household resilience data is based upon 24,850 DHS household surveys (5.2).
Furthermore, "not every traditional authority had surveys conducted within its administrative boundaries" (5.2).
This suggests possible spatial sampling problems in the DHS survey data in the context of its application in this study.
The authors' rationales for using the third level administrative units of traditional authorities include matching the political level at which many projects are planned and assessed, and identifying hotspots of vulnerability that are lost in the aggregation to second level districts (4.4).
The original paper does not contain any further detail on the spatial sampling or distribution of DHS surveys *vis a vis* traditional authorities.

##### Aggregate thematic concepts




The authors use the terms and definitions of "adaptive capacity", "vulnerability" and "resilience" inconsistently in the paper.
Depending on context, both "vulnerability" and "resilience" may refer only to the assets and access portion of the model or to the full model inclusive of adaptive capacity (assets and access), livelihood sensitivity, and exposure.
In some sections and formulas, "adaptive capacity" is used, while in others it appears as its components (assets and access) or even as "household resilience".
The data mapped in figures 3 and 4 are described in different sections of the original paper as resilience, adaptive capacity, and/or vulnerability.
The data mapped in figure 5 are described in different sections of the article as vulnerability or resilience.
Confounding matters further, the authors' definition for resilience is typical for resilience theory, but the formula for resilience is more typical of the well-known Intergovernmental Panel on Climate Change (IPCC) operationalization of "vulnerability" (Gallopín 2006, Smit and Wandel 2006).

For the purposes of the reproduction study, the data visualized in figure 4 of the original study and referred to as 40% Adaptive Capacity in table 2 will be referred to as **adaptive capacity** while the data visualized in figure 5 of the original study and referred to as 100% Household Resilience in table 2 will be referred to as **vulnerability**.

#### Attribute variable transformations

The original study's description of attribute variable transformations is confusing, and we attempt to present all of the evidence in the original study clearly below.
All variables are normalized between zero and five (4.3 and 5.6) with zero representing the worst or poorest condition and five representing the best or richest condition (4.3).
The normalization method is not described, but the poorest and richest conditions are described as "quintiles" with values of zero and five (4.3).
"Quintiles" suggests classification into five classes with equal counts or frequencies.
"Normalization" suggests transforming each variable into a normal distribution.
A minimum of zero and maximum of five suggests rescaling the data to a range from zero to five or classifying the data into six quantiles assigned integer values zero through five.
Four variables were described as (Y/N) nominal data (T1), for which it is not clear how to transform the data into ordinal data with more than two classes.
A similar concern arises for the market access variable with three classes (Rural, Peri-urban, and Urban).
Regardless, there is ambiguity in the method of normalizing, scaling, or classifying each variable.

Adaptive capacity is analyzed with the weighted combination of all asset theme indicators and access theme indicators.
Weights are given in the Variables section.
The formula for this combination is not specified.
For 2004, the authors report a minimum household adaptive capacity score of -0.80 and maximum of 39.33 (5.2).
A maximum score near 40 is intuitive as a theoretical maximum of 40% for the adaptive capacity category.
It is not clear whether the calculation should be a weighted average, weighted sum, weighted combination specified to achieve a maximum of 40%, or some other form of weighted combination.
Results of the average adaptive capacity score for traditional authorities in 2010 are visualized in figure 4.

Livelihood sensitivity is presumably calculated with the weighted combination of its four indicators.
Weights are given in the Variables section.
The formula for this combination is not specified.
Results for this theme are not presented.

Physical exposure may be calculated with the weighted combination of its two indicators.
Weights are given in the Variables section.
The formula for this combination is not specified.
It is not specified whether any geographic transformation is required to combine these two variables.
Results for this theme are not presented.

#### Geographic transformations

Adaptive capacity is analyzed in the spatial units of traditional authorities (4.4, 5.2, F3 and F4).
This aggregation from households to traditional authorities is accomplished with a spatial join (5.2) with an average of the individual household resilience scores (5.2, 6.3, F3 and F4), and classified into four classes with the Natural Breaks Jenks classification method (F3 and F4).
In the methodology section, the authors state that "DHS Indicators were disaggregated to the village level" (4.4).
Since the DHS data is described as using the household level of aggregation, it is not clear how or why the data would be "disaggregated" to the village level.

Vulnerability is analyzed in the spatial units of gridded cells (F5).
Each theme was converted to the raster grid data format (4.6).
The paper does not specify the parameters for raster conversion, including the relationship between vector polygons and raster grid cells or the spatial resolution of the grid cells.
Presumably, only adaptive capacity and livelihood sensitivity were converted, since physical exposure is already in a raster grid format.
The paper does not specify if or how any geographic transformation is required for the biophysical risk grids from the UNEP Global Risk Data Platform.
It may be possible to infer the resolution and methods from close inspection of the final climate vulnerability map (F5).

## Analyses

The final climate vulnerability analysis is calculated with map algebra on a raster grid for each theme using the formula:

`household resilience = adaptive capacity + livelihood sensitivity - physical exposure` (4.6).

The results are presented as a continuous raster grid with a continuous color gradient.
No descriptive statistics of the results are provided.

### Geographical characteristics

The **coordinate reference system(s)** used in the original study are not specified.
However, the study does not appear to include any distance or area calculations: therefore the analysis should not be sensitive to the coordinate reference system used as long as each layer is stored or reprojected into one consistent system.



### Temporal characteristics

The **temporal extent** of the original study was stated as "2004&ndash;2010 based on the availability of the Malawi DHS datasets with GPS data" (4.5).
The study also references Dartmouth Flood Observatory Data from 1999 to 2007 (F5) used to indicate flood risk and a Malawi Vulnerability Assessment Committee (MVAC) Household Economy Approach (HEA) baseline survey conducted between May and July 2003 used to indicate livelihood sensitivity (3.6).
Therefore, it appears that the 2004&ndash;2010 temporal extent applies strictly to the household resilience analysis, and not to the climate vulnerability analysis.

The **temporal support** for the household resilience analysis was longitudinal DHS Survey data collected in 2004 and 2010.
The **temporal support** for the climate vulnerability analysis is an aggregation of data from different sources, ranging from 1999 to 2010 (F5).
**Temporal effects** are not measured or accounted for, although the authors discuss differences between household resilience in 2004 and 2010 (5.3 and 5.4)

### Data exclusion

Some traditional authorities are **missing data** for DHS surveys because no DHS surveys were conducted within their administrative boundaries.
These traditional authorities were excluded from the analysis of household resilience and labelled as 'Areas Missing DHS Data' (5.2).
No **inferences** were made to fill the missing data (5.2).
Some traditional authorities are clearly symbolized with the diagonal hashmarks representing missing data for household resilience (F4), and appear to be similarly excluded from the analysis of climate vulnerability (F5).
However, several other traditional authorities appear white&mdash;not one of the four categories of household resilience (F4).
Some of these areas appear to be excluded from the climate vulnerability analysis while others are not (F5).

The study does not analyze the presence of **outliers** or exclude them.
The study does not **weight samples**.
