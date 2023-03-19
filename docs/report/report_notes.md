The direction of variables is not always clear because "better" (5) or "worse" (0) conditions are not made explicit for each variable transformation.
The variable direction is often intuitive, but not in every case.
This becomes a concern when some components of vulnerability are added while others are subtracted.
For example, the better condition for a household in terms of flood risk is to be at low risk, therefore low flood risk should be assigned a value of five.
However, flood risk becomes part of the physical exposure theme which is then *subtracted* in the formula for calculating climate vulnerability (4.6), yielding counterintuitive results.
Meanwhile, livelihood sensitivity is *added*, therefore each of its indicators should receive high scores of five for good conditions of low sensitivity.
The final model of the study is also referred to equally often in opposite terms: "vulnerability" or "resilience".
Rufat et al (2015) found that the monotonicity of vulnerability indicators should not be assumed.
Therefore, the one certainty is that the individual and thematic variable directions are uncertain.

Based on the described methodology of a weighted combination of values ranging from zero to five, a negative score is inexplicable. (referring to household adaptive capacity scores)

Original analysis does not seem to mask out areas with no data for any of the inputs, e.g. missing traditional authorities?

acquire all DHS passwords as dlginput?
what is the story with all the NULL values in the household survey data?
what is the story with the flood layer? check my test with `flw`

preprocess notebook creates `ta_v.gpkg` but then the georeferencing/coding of 2010 adaptive capacity is in `ta_fig4_v.gpkg` and this is what is loaded into the analysis notebook
