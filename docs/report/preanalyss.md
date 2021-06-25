# Pre-analysis plan based on paper only

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
- Blantyre District, TA Machinjili scored 3.9
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
