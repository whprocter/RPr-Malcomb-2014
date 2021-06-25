# Pre-Registration of Rpr - Reproduction of Malcomb et al 2014 Vulnerability modeling for sub-Saharan Africa

Joseph Holler, Department of Geography, Middlebury College, Middlebury VT 05753
Drew An-Pham, Department of Geography, Middlebury College, Middlebury VT 05753
Kufre Udoh, Department of Geography, Middlebury College, Middlebury VT 05753

Version 1.0 | Created June 25, 2021 | Last Updated June 25, 2021

## Abstract

Malcomb, Weaver and Krakowka ([2014](https://doi.org/10.1016/j.apgeog.2014.01.004)) published one of the first sub-national geographic climate change vulnerability models for a developing country (1.4).
The authors intended for the study to be replicable across space (other African countries with similar data available) (7.1), time (when new suvery data is published) (4.5, 7.1), and vulnerability stimuli (7.1) for the purpose of addressing extreme vulnerability to climate change (1.3) with a model to assist in the allocation and evaluation of foreign aid (1.2).
The methodology was desgined to be "transparent and easily replicable" (2.1) in its use of "locally derived indicators and granular data" (2.1), addressing critiques of vulnerability models aimed at their uncertainty and sensitivity due to problems of scale and spatial aggregation, normative and subjective modelling decisions, and data availability, and challenges in model comparability (2.1).
The model uses household adaptive capacity data United States Agency for International Development (USAID) Demographic and Health Surveys (DHS) (1.4, 4.1) available in 44 African countries (7.1), livelihood sensitivity data from Famine Early Warning Systems Network (FEWSnet) livelihood zones baseline surveys available in 23 African countries (3.6), and global physical exposure data from the United Nations Environment Programme (UNEP) Global Risk Data Platform.

This replication study is motivated by three factors.
First, climate change impacts are increasingly severe in Africa and establishing reproducible and replicable methods for geographic vulnerability modeling may help in allocating resources for climate change adaptation and evaluating the effectiveness of climate change adaptation investments.
Second, a fully reproducible publication can be more readily replicated in new geographic, temporal, and thematic contexts, and tested for uncertainty due to data constraints and subjective modelling decisions.
Third, there is an urgent need to evaluate the reproducibility of research in human-environment and geographical sciences (HEGS) and to establish protocols and infrastructure for conducting and publishing reproduction/replication studies and reproducible research in HEGS.

In this study, we will attempt to identically reproduce the 2010 Malawi Household Resilience model and the Vulnerability to Climate Change model described in Malcomb et al (2014) using The R Project for Statistical Computing and the same data sources cited in the original publication.
We will compare our reproduction results with the orginal results using thematic maps of difference between results and the Spearman's Rho Correlation Coefficient. Additionally, we will compare reproduction results with original results for the household resilience model with a confusion matrix, and for the vulnerability model with a scatterplot.
The original study is a descriptive geographic multi-criteria analysis based on local expert opinion, and therefore has no testable hypotheses or effects.
As a reproduction study, the geographic extent and support will match the original study, for which the extent is the country of Malawi and the support for household resiliency is the third administrative level (Traditional Authorities) (4.4, F4) while the support for climate vulnerability is a raster grid (4.6, F5) with unknown spatial resolution.
The original study was conducted using STATA and ArcGIS, while this replication study will use The R Project for Statistical Computing.

Malcomb, D. W., E. A. Weaver, and A. R. Krakowka. 2014. Vulnerability modeling for sub-Saharan Africa: An operationalized approach in Malawi. *Applied Geography* 48:17–30. DOI:[10.1016/j.apgeog.2014.01.004](https://doi.org/10.1016/j.apgeog.2014.01.004). 

### Keywords

Reproducibility, Vulnerability, GIS, Climate Change, Africa

## Study Design

The reproduction study design will first implement the original study as closely as possible to reproduce the 2010 Household Resilience map (figure 4) and Malawi Vulnerability Map (figure 5). We hypothesize that we will be able to exactly reproduce the same results for both maps.

### Original Study Design

The original study is an observational and descriptive multi-criteria analysis using geographic information systems (GIS) to implement a hierarchical design for a climate change vulnerability model of Malawi.
The model themes, indicators, and weights were selected based upon 70 interviews and 11 village focus groups from field trips in March and August of 2011 (1.4, 4.2, A1).
Themes and indicators were also contextualized in literature (3.3 through 3.7) and adjusted based on redundancy and representativeness across the country (4.3).
The model and weights were adjusted through "several iterations of the model usign alternative weighting schemes" to produce a "final product that reflects Malawi's contextual and perceptual vulnerability" (4.3).
Each theme was constructed of indicators from a single data provider: adaptive capacity is measured with USAID DHS surveys, livelihood sensitivity is measured with FEWSnet/MVAC livelihood zones baseline data, and physical exposure is measured with UNEP Global Risk Data Platform data (T1, T2). 
suggesting a model design based on a combination of factors including expert opinion, deductive theory, inductive data characteristics, and pragmatic data availability.

### Evaluating the Reproduction Results

In order to test the household resilience results, we will georeference the original figure 4 map using QGIS georeferencer plugin.
Using a vector dataset of traditional authorities and the georeferenced map, we will then use zonal statistics to extract the average brightness values, which represent four classes of household resilience, for each traditional authority.
After inspecting a histogram of the mean brightness values, we will reclassify the values as closely to the four classes on the original figure 4 as possible and then manually adjust the attribute values for any misclassified traditional authorities.
We will compare original and reproduction household resilience results by creating a confusion matrix, calculating the Spearman's Rho correlation coefficient (expecting a value of 1 for perfect positive correlation), and creating a thematic map of the difference between the original results and replication results.

In order to compare the Malawi vulnerability results, we will georeference the original figure 5 map using QGIS georeferencer plugin.
We will vectorize the UNEP-Grid raster  input most closely matching the published map and summarize the red, green, and blue brightness values of the original map using zonal statistics.
We will add the green and blue brightness values together to convert the original color ramp into a linear scale of continuous values. 
We will compare original and reproduction Malawi vulnerability results by creating a scatterplot, Spearman's Rho correlation coefficient (expecting a value near 1 for perfect positive correlation), and thematic map of the difference between the original results and replication results.



## Sections of Paper
- 1 Introduction
- 2 Complex vulnerability
- 3 Evidence-based Indicators
- 4 Methodology
- 5 Results
- 6 Discussion
- 7 Conclusion
- F1 Map of Malawi
- F2 Vulnerability web
- T1 Evidence-based complex vulnerability indicators
- T2 Weighted indicators by metatheme **in orange on notecards**
- F3 Malawi Household Resilience (2004)
- F4 Malawi Household Resilience (2010)
- F5 Malawi Composite Vulnerability Index
- A1 Appendix 1
- R References

## Concepts
- Adaptive capacity as "household-level assets to recover from disasters and access to resources" `2.2`
- Exposure: "magnitude and frequency of forced that could stress a system" `2.2`
- Sensitivity: "degree to which a system will respond to an external disturbing force"
- Resilience: "ability of a household to prepare for, respond to and recover from complex drivers of vulnerability"

## Computational Environment
- STATA `4.4` to disaggregate DHS indicators + combine
- ArcGIS Software `4.6` to map + visualize

## Spatial/Temporal Extent
- Traditional Authorities level for DHS vulnerability indicators `4.4`
- extent of Malawi (all territories data where data was available) `4.5`
- temporal scale (2004 - 2010) `4.5`
- exposure data had global extent  `3.7`

## Field Research Trips
- March 2011 `1.4`
- August 2011 `1.4`
- 70 interviews `1.4`
- List of interviewed organizations is provided in Appendix 1 and referenced in section `3.2`
- 11 village focus groups `1.4`
- "multi-leveled, semi-structured interviews" `1.4`
- interview themes: "perceptions of climate change, adaptation, governance, vulnerability, and foreign aid" `3.2`
- "understanding household social and economic practices in the context of environmental uncertainty." `3.2`

## Selecting and weighting indicators
- transcribe and code interviews `3.3`
- synthesize into four metathemes `3.3`
  - assets of land, livestock, income
  - access to markets, food, water, health care, and labor
  - livelihood sensitivity
  - physical exposure to droughts and floods
- themes `3.3` and indicators `3.4, 3.5, 3.6, 3.7` contextualized in literature
- somewhere note collaboration with the DHS Survey folks and the FEWSNet folks as matter of convenience!
- Sources of Indicators `T1` and their weights `T2`
  - Assets: DHS Survey 20%
  - Access: DHS Survey 20%
  - Livelihood Sensitivity: Famine Early Warning Network 20%
  - Biophysical Exposure: UNEP/GRID-Europe 40%
- expert opinion of interviewees used to select and weight indicators `4.2`

---

### Weighting
- based on expert opinion `4.2`
- reduced weight for variables "not representative (of the total population) across the country" or
potential for redundancy" `4.3`
- "several iterations of the model using alternative weighting schemes resulted in a final product that but reflects Malawi's contextual and perceptual vulnerability" `4.3`

### Normalizing
- individual indicators normalized between 0 & 5
  - 0 = worst conditions (poorest quintile)
  - 5 = best condition (richest quintile)

## Data

### GADM
- Districts, prior to maps date of 2012 `F1`
- Traditional Authorities `F3 & F4 captions`

### CIESIN: Gridded Population
- Figure 1 (not used anywhere else in paper)

### UNEP
- Physical Exposure Risk `1.4`

### UNEP/GRID (T2)
- Dartmouth Flood Observatory
  - Data? `Fig 5` 1999 - 2007
- UNEP Global Risk Data Platform on droughts (2009) `F5`
- Continuous raster `5.6`

### FEWSNET
- Livlihood data  `1.4`
- FEWSNET 2005 `T2`
- Malawi Vulnerability Assessment Committee (2005) `F5`
- Livelihood Zones Area District from TAs `5.6`

### USAID DHS Surveys
  - household surveys, 2004 + 2010 `1.4`
  - over 38,5100 surveys `4.1`
  - 25,000+ are women `4.1`

## Theory (T1)

### Physical Exposure (3.7) -- same as next thing (same reference)
- UNEP Global Disaster Risk Platform
  - risks of flood (Peduzzi 2011)
  - drought exposure (Peduzzi 2012) based on
    - global monthly gridded precipitation dataset from the Climactic Research Unit (University of E. Angolia)
    - global standardized precipitation index based on Brooklyn IRI Columbia
  - designed by: UNEP Global Resource Information Database (GRID) Europe

### Biophysical Exposure 40%
- Floods & rain variability, flood events `T1`
  - estimated risk for flood hazards 20% `T2`
  - Global estimated risk index for flood hazard `R w/ link`
- Drought & Dry Spells, drought indiices `T1`
  - exposition to drought events 20% `T2`
  - Physical exposition to drought events 1980 - 2001 `R w/ link`

### Livelihood Sensitivity 20% (3.6)
- interviews with MVAC
- data created in partnership with FEWSNET & USAID
- pre-established livelihood zones - geographic areas where populations share characteristics of farming practices, labor, and enviro. coping strategies
- May to July 2003 Household Economy Approach baseline survey in 11 livelihood zones
- wealth groups created (poor [65%], middle, better-off) in process unique to each zone

#### 4 Indicators of Livelihood Sensitivity
- "% of income that poor households receive from wage labor" `3.6`
  - income source; % poor income from labor `T1`
  - % income from wage labor 6% `T2`
  - report on livelihood zones linked in references (MVAC 2005)
- "% of food that poor households *receive independently from their own farm (??)* indication of sustainability of livelihoods `3.6`
  - ability to meet food needs; % food intake from personal farm `T1`
  - % of food from own farm 6% `T2`
- "% of labor income that is susceptible to market shocks (i.e. tobacco, sugar, tea, & coffee" `3.6`
  - cash crop exposure, % non-food crop (cotton, tobacco, tea) `T1`
  - % income from cash crops 4% `T2`
- "ecological destruction associated with livelihood coping strategies during time of crisis" `3.6`
  - ecological coping effect; access to alternative form of income `T1`
  - disaster coping strategy 4% (FEWNET 2005) `T2`

### Adaptive Capacity
- 40% AC includes:
  - 20% assets
  - 20% access
  - `2.2 & T2`, but `NOT 3.4, 3.5, or T1`
- DHS 2004, 2020 `T2`
- Demographic & Health Survey from Malawi (2010) `F5`

#### Assets
- larger landholders can diversify crops and sell food `3.4`
  - amount of arable land per HH `T1`
  - arable lands (hectares) 6%
- animals used as coping strategy `3.4`
  - livestock; number oof animals per HH by type `T1`
  - number of livestock units 4% `T2`
- wealth (disposable capital assets) `3.4`
  - money; wealth index (based on owned `T1` assets)
  - wealth index score 4% `T2`
- good health `3.4`
  - sick in the past 12 months good health `T1`
  - in household sick in past 12 months 3% `T2`
- orphans are a socially vulnerable set of the population orphan care adds burdens `3.4`
  - number of orphans or vulnerable children `T1`
  - number of orphans in households 3% `T2`
- income (immediately accessible resources) `3.4`
  - NOT in `T1`

#### Access
- to the electrical grid `3.5`
  - basics, electricity (Y/N) `T1`
  - electricity 3% `T2`
- basics, cooking fuel type `T1`
  - NOT in section `3.5` unless you consider "selling of charcoal is one of the top coping strategies during periods of food insecurity and market shocks" `3.5`
  - type of cooking fuel 2% `T2`
- burden of collecting water `3.5`
  - basics, water (time to source) `T1`
  - time to water source 4% `T2`
- market access; rural, peri-urban, urban `T1`
  - NOT in section `3.5`
  - house setting (urban/rural) 2%  `T2`
- nearest vehicle-accessible road `3.5`
  - NOT in `T1`
- radios `3.5`
  - technology sharing/own a radio (Y/N) `T1`
  - own a radio 3% `T2`
- own a cell phone (Y/N)/media & information `T1`
  - NOT in section `3.5`
  - own a cell phone 4% `T2`
- households headed by females are more vulnerable based on less access to sources of power, land, and resources `3,5`
  - power and decision-making female-headed HH (Y/N) `T1`
  - sex of head of household 2% `T2`
- households headed by one parent or by children (encompassed in the variable family structure) werre seen as more vulnerable
  - NOT in `T1`

---

## Combining
- each meta data theme converted to Raster format `4.6`
- overall score calculated with map algebra `4.6`
- household resilience = adaptive capacity + livelihood sensitivity - physical exposure `4.6`
- final maps appears to be raster `F5`
- resilience scores are 203 traditional authority (polygons) `F4`
- "DHS Indicators were disaggregated to the village level" --> "combined @ a suitable administrative level for analysis" `4.4`
- "explanation on using survey data with GPS information is available from the DHS website and was instrumented this index" `4.4`
- Malawi contained 28 administrative districts (but too large - an "inappropriate scale for household vulnerability dynamics") `4.4` - hotspots of vulnerability would be lost
- "analysis of the weighted DHS vulnerability indicators was conducted at the administrative scale of Traditional Authorities"
- There are over 250 populated TAs in Malawi `4.4`
- "Not every traditional authority had surveys conducted within its administrative boundaries" `5.2`
- "TAs with missing information was indicated as 'Areas Missing DHS Data'" `5.2`

## Checking Results
- 203 TAs with Data in 2010 `F3`
- Range of HH Resilience Scores from 11.48 - 25.77 `F3`
- 24,850 HH surveys in 2010 `5.2`
- Blantyre District, TA Machinjili scored `3.9`
- Machinga District, TA Mposa scored highest (max) "average household score nationwide was 17.63" `5.3`
- `F4`- Malawi Household Resiliences (2010)
- 173 TA's had temporal data (both 2004 & 2010) `6.3`

### Checking Results (on our end)
- georeference
- zonal stats
- classify & edit
- spearman's rho
- cross tabs
- scatterplot  
