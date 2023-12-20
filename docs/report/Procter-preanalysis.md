I plan to reproduce the Malcomb study and make the following contributions to the study:

First, I plan to visualize the original Figure 5 from the study directly in the report.  Figure 5 (original vulnerability raster layer) was brought in as a data object (imported into the R script) and was correctly used in creating the difference raster layer in the prior reproduction, but it was never visualized for the user to see.  I will visualize it for the reader to see and make visual comparisons with.

Second, I plan to create an additional (hopefully interactive) figure that amends the Figure 5 output (vulnerability map) to show vulnerability by TA, rather than just a raster grid.  I will polygonize/aggregate the vulnerability raster grid and joined with TA names to produce a new map to be titled `ta_vuln_map`.  Showing vulnerability by TA allows us to easily include natural parks/wildlife refuges, as well as identify areas where there was missing data for the TAs (stemming from HH surveys).

Additionally, I plan to join TA name to the vulnerability by TA layer, and then create a sorted data frame that shows lists the names of TAs in decending order of their vulnerability scores.  This will provides policymakers and stakeholders with a direct list to see the most vulnerable TAs and could be useful in terms of directing aid.

Lastly, I will add z-scored histograms to several of the raster figure outputs (maps) to better visualize the original vulnerability raster's spread of values, as well as the reproduction - original vulnerability (difference) raster's spread of values.
