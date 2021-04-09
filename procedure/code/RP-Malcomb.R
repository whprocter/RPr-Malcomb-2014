#### Reproduction of Malcomb et al 2014 ####
# Malcomb, D. W., E. A. Weaver, and A. R. Krakowka. 2014. Vulnerability modeling for sub-Saharan Africa: An operationalized approach in Malawi. Applied Geography 48:17–30.
# https://doi.org/10.1016/j.apgeog.2014.01.004 
# Authors: Kufre Udoh, Joseph Holler, and Middlebury College Spring 2019 Geography 323 class
# https://gis4dev.github.io/ 

# load required packages --------------------------------------------------

packages <- c("downloader","haven","stars","dplyr","sf","rdhs", "classInt", "exactextractr", "readr", "ggplot2")
setdiff(packages, rownames(installed.packages()))
install.packages(setdiff(packages, rownames(installed.packages())), quietly=TRUE)

library(downloader)
library(haven)
library(sf)
library(stars)
library(dplyr)
library(classInt)
library(rdhs)
library(exactextractr)
library(readr)
library(ggplot2)

# download and unzip data  ------------------------------------------------

if (!"zip_files" %in% list.files("data")){
  dir.create("data/zip_files")
}

if (!"traditional_authorities" %in% list.files("data")){
  # Malawi administrative areas from GADM version 2.8 https://gadm.org/download_country_v2.html
  download("https://biogeo.ucdavis.edu/data/gadm2.8/shp/MWI_adm_shp.zip", "data/zip_files/MWI_adm_shp.zip")
  unzip("data/zip_files/MWI_adm_shp.zip", exdir = "./data/traditional_authorities")
}

if (!"livelihood_zones" %in% list.files("data")){
  # Malawi livelihood zones from FEWS NET Data Center https://fews.net/fews-data/335
  download("https://fews.net/data_portal_download/download?data_file_path=http%3A//shapefiles.fews.net.s3.amazonaws.com/LHZ/MW_LHZ_2009.zip", "data/zip_files/MW_LHZ_2009.zip")
  unzip("data/zip_files/MW_LHZ_2009.zip", exdir = "./data/livelihood_zones")
}

if (!"lakes" %in% list.files("data")) {
  # major lakes in malawi: http://www.masdap.mw/
  dir.create("data/lakes")
  download(
    "http://www.masdap.mw/geoserver/ows?outputFormat=csv&service=WFS&srs=EPSG%3A4326&request=GetFeature&typename=geonode%3Amajor_lakes&version=1.0.0",
    "data/lakes/major_lakes.csv"
  )
}

# project name: Social Vulnerability in Malawi
# project description: 
# I am researching reproducibility of geographic information science research, and in particular,studying the reproducibility and replicability of social vulnerability mapping research. In this particular case, I am attempting to reproduce the methods in a published research article:
# Malcomb, D. W., E. A. Weaver, and A. R. Krakowka. 2014. Vulnerability modeling for sub-Saharan Africa: An operationalized approach in Malawi. Applied Geography 48:17–30. http://dx.doi.org/10.1016/j.apgeog.2014.01.004.
# The authors use geocoded DHS surveys for Malawi in 2004 and 2010 in combination with FEWSnet livelihood data and UNEP flood and drought risk data. My sole purpose for registering for DHS data at this time is to attempt to reproduce the same methodology in the Malcomb et al. article. The methods of this paper call for a spatial join of household surveys and traditional authorities in Malawi in order to calculate adaptive capacity and vulnerability scores by traditional authorities.
# info about accessing DHS data from R: https://www.r-bloggers.com/interacting-with-the-demographic-and-health-surveys-dhs-program-data/ 

email = readline(prompt="Enter DHS Login Email: ")
project = readline(prompt="Enter Project Name: ")

set_rdhs_config(
  email = email,
  project = project,
  config_path = "rdhs.json",   #change this to the SCRATCH folder
  global = FALSE,
  cache_path = "./data/dhs"
)

# 2010 DHS Data: MWHR61SV
# 2010 DHS GPS Points: MWGE62FL
# 2004 DHS Data: MWHR4ESV
# 2004 DHS GPS Points: MWGE4BFL

dhs_downloads = get_datasets(
  c("MWHR61SV", "MWGE62FL", "MWHR4ESV", "MWGE4BFL"),
  all_lower = FALSE,
  download_option = "rds"
)

check = c("MWGE4BFL.rds",
          "MWGE62FL.rds",
          "MWHR4ESV.rds",
          "MWHR61SV.rds")

if (sum(check == list.files("data/dhs/datasets")) == 4){
  
# calculating 2010 adaptive capacity  -------------------------------------
message("calculating 2010 adaptive capacity...")

ta = read_sf("data/traditional_authorities/MWI_adm2.shp") %>%
  st_make_valid() 

lhz = read_sf(dsn = "data/livelihood_zones/MW_LHZ_2009.shp") %>% st_make_valid()

dhsclusters_2010 = readRDS(dhs_downloads$MWGE62FL) %>%
  as("sf") %>% 
  st_transform(3395) %>% 
  # joining id for traditional authorities and livelihood zones to dhs clusters
  st_join(st_transform(select(ta, ID_2),3395)) %>%
  st_join(st_transform(select(lhz, FNID),3395)) %>%
  rename(ta_id = ID_2,
         lhz_id = FNID,
         urban_rural = URBAN_RURA)

dhshh_2010 = readRDS(dhs_downloads$MWHR61SV) %>% as_tibble() %>%  zap_labels() 
# 24825 obs. of 4596 variables

# making an index to remove unknown values 
rmv_2010 = dhshh_2010 %>%  filter(
  HV246A == 98 |
    HV246A == 99 |
    HV246D == 98 |
    HV246D == 99 |
    HV246E == 98 |
    HV246E == 99 |
    HV246G == 98 |
    HV246G == 99 |
    HV219  == 9 |
    HV243A == 9 |
    HV245  == 99 |
    HV206  == 9 |
    HV204  == 999 |
    HV204  == 998 |
    HV226  == 99 |
    HV226  == 95 |
    HV226  == 96 |
    HV207  ==  9 
) %>% select(HHID)

# capacity in traditional authorities 
ta_capacity_2010 = dhshh_2010 %>%
  # joining traditional authority ids and urban_rural column 
  left_join(st_drop_geometry(select(dhsclusters_2010, DHSCLUST, ta_id, urban_rural)), by = c("HV001" = "DHSCLUST")) %>%
  select(
    HHID,
    HV001,
    HV002,
    ta_id,
    urban_rural,
    HV246A,
    HV246D,
    HV246E,
    HV246G,
    HV248,
    HV245,
    HV271,
    HV251,
    HV204,
    HV206,
    HV226,
    HV219,
    HV243A,
    HV207
  ) %>%
  # removing values based on index and where there are NAs 
  filter(!HHID %in% rmv_2010$HHID) %>% 
  filter(is.na(ta_id) == F) %>% 
  # 24030 obs. of 19 variables 
  # removing any surveys where all livestock values were NA
  filter(!(is.na(HV246A) == T & is.na(HV246D)==T & is.na(HV246E)== T & is.na(HV246G) ==T)) %>% 
  # 24028 obs. of 19 variables 
  # using rowwise() to find sum of livestock by household 
  rowwise %>%
  mutate(hhlivestock = sum(HV246A, HV246D, HV246E, HV246G, na.rm = T)) %>%
  ungroup %>%
  # using percent_rank(), those  
  # in cases where desc() is used, having a greater value before ranked makes a household more vulnerable 
  mutate(
    livestock = percent_rank(hhlivestock) * 4 + 1,
    sick = percent_rank(desc(HV248)) * 4 + 1,
    land = percent_rank(HV245) * 4 + 1,
    wealth = percent_rank(HV271) * 4 + 1,
    orphans = percent_rank(desc(HV251)) * 4 + 1,
    # changing 996 to 0 as it takes no time to get water on premises
    HV204 = ifelse(HV204 == 996, 0, HV204),
    water = percent_rank(desc(HV204)) * 4 + 1,
    electricity = percent_rank(HV206) * 4 + 1,
    cooking = percent_rank(desc(HV226)) * 4 + 1,
    sexcat = percent_rank(desc(HV219)) * 4 + 1,
    cellphone = percent_rank(desc(HV243A)) * 4 + 1,
    radio = percent_rank(HV207) * 4 + 1,
    urbanruralscore = ifelse(urban_rural == "U", 5, 1)
  ) %>%
  # calculating capacity score based on table 2 in malcomb et al 
  rowwise %>%
  mutate(
    capacity = sum(
      livestock * 0.04,
      sick * 0.03,
      land * 0.06,
      wealth * 0.04,
      orphans * 0.03,
      water * 0.04,
      electricity * 0.03,
      cooking * 0.02,
      sexcat * 0.02,
      cellphone * 0.04,
      radio * 0.03,
      urbanruralscore * 0.02,
      # NAs are not removed here to filter out incomplete surveys later on
      na.rm = F
    ) 
  ) %>%  
  # removing incomplete surveys 
  filter(is.na(capacity) == F)%>%
  # 19996 obs. of 33 variables 
  ungroup %>%
  group_by(ta_id) %>%
  summarize(
    capacity_avg = mean(capacity),
    capacity_min = min(capacity),
    capacity_max = max(capacity),
    capacity_sd = sd(capacity)
  ) 
# 222 obs. of 5 variables

# join mean capacity to traditional authorities
ta = left_join(
  ta,
  select(ta_capacity_2010, ta_id, capacity_2010 = capacity_avg),
  by = c("ID_2" = "ta_id")
)

# making capacity score resemble malcomb et al's work 
ta = mutate(ta, capacity_2010 = capacity_2010 * 20)
# 256 features 

# preparing breaks for mapping 
ta_brks = filter(ta, is.na(capacity_2010) == F) %>% {classIntervals(.$capacity_2010, 4, style = "jenks")}

ta = mutate(ta, capacity_2010_brks = case_when(
  capacity_2010 <= ta_brks$brks[2] ~ paste(round(ta_brks$brks[1],2),"-", round(ta_brks$brks[2],2), sep = " "),
  capacity_2010 > ta_brks$brks[2] & capacity_2010 <= ta_brks$brks[3] ~ paste(round(ta_brks$brks[2],2),"-", round(ta_brks$brks[3],2), sep = " "),
  capacity_2010 > ta_brks$brks[3] & capacity_2010 <= ta_brks$brks[4] ~ paste(round(ta_brks$brks[3],2),"-", round(ta_brks$brks[4], 2), sep = " "),
  T ~ paste(round(ta_brks$brks[4],2),"-", round(ta_brks$brks[5],2), sep = " ")
))

# capacity in livelihood zones 
lhz_capacity = dhshh_2010 %>%
  # joining traditional authority ids and urban_rural column 
  left_join(st_drop_geometry(select(dhsclusters_2010, DHSCLUST, lhz_id, urban_rural)), by = c("HV001" = "DHSCLUST")) %>%
  select(
    HHID,
    HV001,
    HV002,
    lhz_id,
    urban_rural,
    HV246A,
    HV246D,
    HV246E,
    HV246G,
    HV248,
    HV245,
    HV271,
    HV251,
    HV204,
    HV206,
    HV226,
    HV219,
    HV243A,
    HV207
  ) %>%
  # removing values based on index and where there are NAs 
  filter(!HHID %in% rmv_2010$HHID) %>% 
  filter(is.na(lhz_id) == F) %>% 
  # 23968 obs. of 19 variables 
  # removing any surveys where all livestock values were NA
  filter(!(is.na(HV246A) == T & is.na(HV246D)==T & is.na(HV246E)== T & is.na(HV246G) ==T)) %>% 
  # 23966 obs. of 19 variables 
  # using rowwise() to find sum of livestock by household 
  rowwise %>%
  mutate(hhlivestock = sum(HV246A, HV246D, HV246E, HV246G, na.rm = T)) %>%
  ungroup %>%
  # using percent_rank(), those  
  # in cases where desc() is used, having a greater value before ranked makes a household more vulnerable 
  mutate(
    livestock = percent_rank(hhlivestock) * 4 + 1,
    sick = percent_rank(desc(HV248)) * 4 + 1,
    land = percent_rank(HV245) * 4 + 1,
    wealth = percent_rank(HV271) * 4 + 1,
    orphans = percent_rank(desc(HV251)) * 4 + 1,
    # changing 996 to 0 as it takes no time to get water on premises
    HV204 = ifelse(HV204 == 996, 0, HV204),
    water = percent_rank(desc(HV204)) * 4 + 1,
    electricity = percent_rank(HV206) * 4 + 1,
    cooking = percent_rank(desc(HV226)) * 4 + 1,
    sexcat = percent_rank(desc(HV219)) * 4 + 1,
    cellphone = percent_rank(desc(HV243A)) * 4 + 1,
    radio = percent_rank(HV207) * 4 + 1,
    urbanruralscore = ifelse(urban_rural == "U", 5, 1)
  ) %>%
  # calculating capacity score based on table 2 in malcomb et al 
  rowwise %>%
  mutate(
    capacity = sum(
      livestock * 0.04,
      sick * 0.03,
      land * 0.06,
      wealth * 0.04,
      orphans * 0.03,
      water * 0.04,
      electricity * 0.03,
      cooking * 0.02,
      sexcat * 0.02,
      cellphone * 0.04,
      radio * 0.03,
      urbanruralscore * 0.02,
      # NAs are not removed here to filter out incomplete surveys later on
      na.rm = F
    ) 
  ) %>%  
  # removing incomplete surveys 
  filter(is.na(capacity) == F)%>%
  # 19996 obs. of 33 variables 
  ungroup %>%
  group_by(lhz_id) %>%
  summarize(
    capacity_avg = mean(capacity),
    capacity_min = min(capacity),
    capacity_max = max(capacity),
    capacity_sd = sd(capacity)
  ) 

lhz = left_join(lhz,
               select(lhz_capacity, lhz_id, capacity_avg),
               by = c("FNID" = "lhz_id")) %>% 
  rename(capacity = capacity_avg)

# making capacity score resemble malcomb et al's work 
lhz = mutate(lhz, capacity = capacity * 20) 

# preparing breaks for mapping 
lhz_brks = filter(lhz, is.na(capacity) == F) %>%  {classIntervals(.$capacity, 4, style = "jenks")}

lhz = mutate(lhz, capacity_brks = case_when(
  capacity <= lhz_brks$brks[2] ~ paste(round(lhz_brks$brks[1],2),"-", round(lhz_brks$brks[2],2), sep = " "),
  capacity > lhz_brks$brks[2] & capacity <= lhz_brks$brks[3] ~ paste(round(lhz_brks$brks[2],2),"-", round(lhz_brks$brks[3],2), sep = " "),
  capacity > lhz_brks$brks[3] & capacity <= lhz_brks$brks[4] ~ paste(round(lhz_brks$brks[3],2),"-", round(lhz_brks$brks[4], 2), sep = " "),
  T ~ paste(round(lhz_brks$brks[4],2),"-", round(lhz_brks$brks[5],2), sep = " ")
))

# calculating 2004 adaptive capacity --------------------------------------
message("calculating 2004 adaptive capacity...")

dhsclusters_2004 = readRDS(dhs_downloads$MWGE4BFL) %>% 
  as("sf")%>%
  st_transform(3395) %>% 
  # joining id for traditional authorities to dhs clusters
  st_join(st_transform(select(ta, ID_2),3395)) %>%
  rename(ta_id = ID_2,
         urban_rural = URBAN_RURA)

dhshh_2004 = readRDS(dhs_downloads$MWHR4ESV) %>% as_tibble %>%  zap_labels()
#13664 obs. of 1431 variables 

# variables from dhshh_2004
# livestock: SH29EA (goats), SH29EB (pigs), SH29EC (cattle), SH29ED (sheep)
# sick:SH11$01-18
# land : SH29C
# wealth : HV271 (same)
# orphans: HV101$01-18 foster = 11
# water: HV204 (same) 
# electricity: HV206 (same)
# cooking: HV226 (same) 
# sexcat: HV219 (same)
# cellphone: SH27E  
# radio: HV207 (same) 

rmv_2004 = dhshh_2004 %>%  filter(
  SH29EA == 999 |
    SH29EB == 999 |
    SH29EC == 999 |
    SH29ED == 999 |
    `SH11$01` == 9 |
    `SH11$02` == 9 |
    `SH11$03` == 9 |
    `SH11$04` == 9 |
    `SH11$05` == 9 |
    `SH11$06` == 9 |
    `SH11$07` == 9 |
    `SH11$08` == 9 |
    `SH11$09` == 9 |
    `SH11$10` == 9 |
    `SH11$11` == 9 |
    `SH11$12` == 9 |
    `SH11$13` == 9 |
    `SH11$14` == 9 |
    `SH11$15` == 9 |
    `SH11$16` == 9 |
    `SH11$17` == 9 |
    `SH11$18` == 9 |
    SH29C == 9998 |
    SH29C == 9999 |
    `HV101$01` == 99 |
    `HV101$02` == 99 |
    `HV101$03` == 99 |
    `HV101$04` == 99 |
    `HV101$05` == 99 |
    `HV101$06` == 99 |
    `HV101$07` == 99 |
    `HV101$08` == 99 |
    `HV101$09` == 99 |
    `HV101$10` == 99 |
    `HV101$11` == 99 |
    `HV101$12` == 99 |
    `HV101$13` == 99 |
    `HV101$14` == 99 |
    `HV101$15` == 99 |
    `HV101$16` == 99 |
    `HV101$17` == 99 |
    `HV101$18` == 99 |
    `HV101$01` == 98 |
    `HV101$02` == 98 |
    `HV101$03` == 98 |
    `HV101$04` == 98 |
    `HV101$05` == 98 |
    `HV101$06` == 98 |
    `HV101$07` == 98 |
    `HV101$08` == 98 |
    `HV101$09` == 98 |
    `HV101$10` == 98 |
    `HV101$11` == 98 |
    `HV101$12` == 98 |
    `HV101$13` == 98 |
    `HV101$14` == 98 |
    `HV101$15` == 98 |
    `HV101$16` == 98 |
    `HV101$17` == 98 |
    `HV101$18` == 98 |
    HV204 == 999 |
    HV206 == 9 |
    HV226 == 99 |
    HV226 == 96 |
    HV219 == 9 |
    SH27E == 9 |
    HV207 == 9
) %>% select(HHID)

ta_capacity_2004 = dhshh_2004 %>%
  # joining traditional authority ids and urban_rural column 
  left_join(st_drop_geometry(select(dhsclusters_2004, DHSCLUST, ta_id, urban_rural)), by = c("HV001" = "DHSCLUST")) %>%
  select(
    HHID,
    HV001,
    HV002,
    ta_id,
    urban_rural,
    SH29EA,
    SH29EB,
    SH29EC,
    SH29ED,
    `SH11$01`,
    `SH11$02`,
    `SH11$03`,
    `SH11$04`,
    `SH11$05`,
    `SH11$06`,
    `SH11$07`,
    `SH11$08`,
    `SH11$09`,
    `SH11$10`,
    `SH11$11`,
    `SH11$12`,
    `SH11$13`,
    `SH11$14`,
    `SH11$15`,
    `SH11$16`,
    `SH11$17`,
    `SH11$18`,
    SH29C,
    HV271,
    `HV101$01`,
    `HV101$02`,
    `HV101$03`,
    `HV101$04`,
    `HV101$05`,
    `HV101$06`,
    `HV101$07`,
    `HV101$08`,
    `HV101$09`,
    `HV101$10`,
    `HV101$11`,
    `HV101$12`,
    `HV101$13`,
    `HV101$14`,
    `HV101$15`, 
    `HV101$16`,
    `HV101$17`,
    `HV101$18`,
    HV204,
    HV206,
    HV226,
    HV219,
    SH27E,
    HV207
  ) %>%
  # removing values based on index and where there are NAs 
  filter(!HHID %in% rmv_2004$HHID) %>% 
  filter(is.na(ta_id) == F) %>% 
  # 13270 obs. of 52 variables 
  # removing any surveys where all livestock values were NA
  filter(!(is.na(SH29EA) == T & is.na(SH29EB) == T & is.na(SH29EC) == T & is.na(SH29ED) == T)) %>% 
  # 13270 obs. of 52 variables 
  #removing any surveys where all sick values were NA
  filter(
    !(
      is.na(`SH11$01`) == T &
        is.na(`SH11$02`) == T &
        is.na(`SH11$03`) == T &
        is.na(`SH11$04`) == T &
        is.na(`SH11$05`) == T &
        is.na(`SH11$06`) == T &
        is.na(`SH11$07`) == T &
        is.na(`SH11$08`) == T &
        is.na(`SH11$09`) == T &
        is.na(`SH11$10`) == T &
        is.na(`SH11$11`) == T &
        is.na(`SH11$12`) == T &
        is.na(`SH11$13`) == T &
        is.na(`SH11$14`) == T &
        is.na(`SH11$15`) == T &
        is.na(`SH11$16`) == T &
        is.na(`SH11$17`) == T &
        is.na(`SH11$18`) == T
    )
  ) %>% 
  # 12570 obs. of 52 variables
  # removing any surveys were all relationship to household value were NA (orphan/foster child variable)
  filter(
    !(
      is.na(`HV101$01`) == T &
        is.na(`HV101$02`) == T &
        is.na(`HV101$03`) == T &
        is.na(`HV101$04`) == T &
        is.na(`HV101$05`) == T &
        is.na(`HV101$06`) == T &
        is.na(`HV101$07`) == T &
        is.na(`HV101$08`) == T &
        is.na(`HV101$09`) == T &
        is.na(`HV101$10`) == T &
        is.na(`HV101$11`) == T &
        is.na(`HV101$12`) == T &
        is.na(`HV101$13`) == T &
        is.na(`HV101$14`) == T &
        is.na(`HV101$15`) == T &
        is.na(`HV101$16`) == T &
        is.na(`HV101$17`) == T &
        is.na(`HV101$18`) == T
    )
  ) %>%  
  # 12570 obs. of 52 variables
  # using rowwise() to find sum of livestock  and sick residents by household 
  rowwise %>%
  mutate(hhlivestock = sum(SH29EA, SH29EB, SH29EC, SH29ED, na.rm = T),
         hhsick = sum(
           `SH11$01`,
           `SH11$02`,
           `SH11$03`,
           `SH11$04`,
           `SH11$05`,
           `SH11$06`,
           `SH11$07`,
           `SH11$08`,
           `SH11$09`,
           `SH11$10`,
           `SH11$11`,
           `SH11$12`,
           `SH11$13`,
           `SH11$14`,
           `SH11$15`,
           `SH11$16`,
           `SH11$17`,
           `SH11$18`,
           na.rm = T
         ),
         `HV101$01` = case_when(is.na(`HV101$01`) == F & `HV101$01` != 11 ~ 0, `HV101$01` == 11 ~ 1),
         `HV101$02` = case_when(is.na(`HV101$02`) == F & `HV101$02` != 11 ~ 0, `HV101$02` == 11 ~ 1),
         `HV101$03` = case_when(is.na(`HV101$03`) == F & `HV101$03` != 11 ~ 0, `HV101$03` == 11 ~ 1),
         `HV101$04` = case_when(is.na(`HV101$04`) == F & `HV101$04` != 11 ~ 0, `HV101$04` == 11 ~ 1),
         `HV101$05` = case_when(is.na(`HV101$05`) == F & `HV101$05` != 11 ~ 0, `HV101$05` == 11 ~ 1),
         `HV101$06` = case_when(is.na(`HV101$06`) == F & `HV101$06` != 11 ~ 0, `HV101$06` == 11 ~ 1),
         `HV101$07` = case_when(is.na(`HV101$07`) == F & `HV101$07` != 11 ~ 0, `HV101$07` == 11 ~ 1),
         `HV101$08` = case_when(is.na(`HV101$08`) == F & `HV101$08` != 11 ~ 0, `HV101$08` == 11 ~ 1),
         `HV101$09` = case_when(is.na(`HV101$09`) == F & `HV101$09` != 11 ~ 0, `HV101$09` == 11 ~ 1),
         `HV101$10` = case_when(is.na(`HV101$10`) == F & `HV101$10` != 11 ~ 0, `HV101$10` == 11 ~ 1),
         `HV101$11` = case_when(is.na(`HV101$11`) == F & `HV101$11` != 11 ~ 0, `HV101$11` == 11 ~ 1),
         `HV101$12` = case_when(is.na(`HV101$12`) == F & `HV101$12` != 11 ~ 0, `HV101$12` == 11 ~ 1),
         `HV101$13` = case_when(is.na(`HV101$13`) == F & `HV101$13` != 11 ~ 0, `HV101$13` == 11 ~ 1),
         `HV101$14` = case_when(is.na(`HV101$14`) == F & `HV101$14` != 11 ~ 0, `HV101$14` == 11 ~ 1),
         `HV101$15` = case_when(is.na(`HV101$15`) == F & `HV101$15` != 11 ~ 0, `HV101$15` == 11 ~ 1), 
         `HV101$16` = case_when(is.na(`HV101$16`) == F & `HV101$16` != 11 ~ 0, `HV101$16` == 11 ~ 1),
         `HV101$17` = case_when(is.na(`HV101$17`) == F & `HV101$17` != 11 ~ 0, `HV101$17` == 11 ~ 1),
         `HV101$18` = case_when(is.na(`HV101$18`) == F & `HV101$18` != 11 ~ 0, `HV101$18` == 11 ~ 1),
         hhorphans = sum(
           `HV101$01`,
           `HV101$02`,
           `HV101$03`,
           `HV101$04`,
           `HV101$05`,
           `HV101$06`,
           `HV101$07`,
           `HV101$08`,
           `HV101$09`,
           `HV101$10`,
           `HV101$11`,
           `HV101$12`,
           `HV101$13`,
           `HV101$14`,
           `HV101$15`,
           `HV101$16`,
           `HV101$17`,
           `HV101$18`,
           na.rm = T
         )
  ) %>% 
  ungroup %>% 
# using percent_rank(), those in cases where desc() is used, having a greater value before ranked makes a household more vulnerable 
mutate(
  livestock = percent_rank(hhlivestock) * 4 + 1,
  sick = percent_rank(desc(hhsick)) * 4 + 1,
  land = percent_rank(SH29C) * 4 + 1,
  wealth = percent_rank(HV271) * 4 + 1,
  orphans = percent_rank(desc(hhorphans)) * 4 + 1,
  # changing 996 to 0 as it takes no time to get water on premises
  HV204 = ifelse(HV204 == 996, 0, HV204),
  water = percent_rank(desc(HV204)) * 4 + 1,
  electricity = percent_rank(HV206) * 4 + 1,
  cooking = percent_rank(desc(HV226)) * 4 + 1,
  sexcat = percent_rank(desc(HV219)) * 4 + 1,
  cellphone = percent_rank(desc(SH27E)) * 4 + 1,
  radio = percent_rank(HV207) * 4 + 1,
  urbanruralscore = ifelse(urban_rural == "U", 5, 1)
) %>%
  # calculating capacity score based on table 2 in malcomb et al 
  rowwise %>%
  mutate(
    capacity = sum(
      livestock * 0.04,
      sick * 0.03,
      land * 0.06,
      wealth * 0.04,
      orphans * 0.03,
      water * 0.04,
      electricity * 0.03,
      cooking * 0.02,
      sexcat * 0.02,
      cellphone * 0.04,
      radio * 0.03,
      urbanruralscore * 0.02,
      # NAs are not removed here to filter out incomplete surveys later on
      na.rm = F
    ) 
  ) %>%  
  # removing incomplete surveys 
  filter(is.na(capacity) == F) %>% 
  # 8797 obs. of 33 variables 
  ungroup %>%
  group_by(ta_id) %>%
  summarize(
    capacity_avg = mean(capacity),
    capacity_min = min(capacity),
    capacity_max = max(capacity),
    capacity_sd = sd(capacity)
  ) 
# 183 obs. 5 variables

# join mean capacity to traditional authorities
ta = left_join(
  ta,
  select(ta_capacity_2004, ta_id, capacity_2004 = capacity_avg),
  by = c("ID_2" = "ta_id")
) 

# making capacity score resemble malcomb et al's work 
ta = mutate(ta, capacity_2004 = capacity_2004 * 20)  
# 256 features 

# preparing breaks for mapping 
ta_brks = filter(ta, is.na(capacity_2004) == F) %>% {classIntervals(.$capacity_2004, 4, style = "jenks")}

ta = mutate(ta, capacity_2004_brks = case_when(
  capacity_2004 <= ta_brks$brks[2] ~ paste(round(ta_brks$brks[1],2),"-", round(ta_brks$brks[2],2), sep = " "),
  capacity_2004 > ta_brks$brks[2] & capacity_2004 <= ta_brks$brks[3] ~ paste(round(ta_brks$brks[2],2),"-", round(ta_brks$brks[3],2), sep = " "),
  capacity_2004 > ta_brks$brks[3] & capacity_2004 <= ta_brks$brks[4] ~ paste(round(ta_brks$brks[3],2),"-", round(ta_brks$brks[4], 2), sep = " "),
  T ~ paste(round(ta_brks$brks[4],2),"-", round(ta_brks$brks[5],2), sep = " ")
))

# saving tables from calculating adaptive capacity scores and removing unneeded objects  ----------------
if (!"outputs" %in% list.files()){
dir.create("outputs")
}

save(ta_capacity_2010, ta_capacity_2004, lhz_capacity, file = "outputs/adaptive_capacity.Rdata")

remove(list = filter(as_tibble(ls()), !value %in% c("ta", "lhz"))$value)

# calculating vulnerability score ---------------------------------------------------------
message("calculating vunerability scores...")

# for later intersections 
st_agr(ta) = "constant"

# extent of analysis 
source("scripts/extent.R")

# UNEP layers
dr = read_stars("data/dr_physexp/dr1010ipeykx.tif", RasterIO = dr_ext) %>% st_set_crs(4326)
fl = read_stars("data/flood_risk/fl1010irmt.tif", RasterIO = fl_ext) %>% st_set_crs(4326)

# creating blank raster in extent
grid = st_as_stars(st_bbox(b), dx = 0.041667, dy = 0.041667)
grid[[1]][] = NA

# reprojecting and clipping rasters to new extent
dr = st_warp(dr, grid, use_gdal = T, method = "bilinear")
fl = st_warp(fl, grid, method = "near")

# removing factors from fl
fctr = as.numeric(levels(fl[[1]]))[fl[[1]]]
fl = grid
fl[[1]][] = fctr

# clipping traditional authorities with livelihood zones in order to remove lake
st_clip = function(x,y) {st_intersection(x, st_union(st_geometry(y)))}

ta_2010 = st_clip(st_transform(filter(ta, is.na(capacity_2010) == F), 3395), st_buffer(st_transform(lhz, 3395), .01)) %>%
  st_transform(4326)
# 222 features 

# making capacity rasters 
ta_capacity = st_rasterize(ta_2010[, 'capacity_2010'], grid)
lhz_capacity = st_rasterize(lhz[,'capacity'], grid) 

vuln = function(geo) {
  # creating mask layer
  mask = geo 
  mask[mask > 0] = 1
  mask[mask == 0] = NA
  
  # masking flood and drought 
  flood = fl * mask * 4
  drought = dr * mask
  
  # reclassifying drought layer
  qt = quantile(drought[[1]], probs = seq(0, 1, 0.2), na.rm = T)
  
  drought = drought %>%
    mutate(
      recoded = case_when(
        drought[[1]] <= qt[[2]] ~ 1,
        drought[[1]] > qt[[2]] & drought[[1]] <= qt[[3]] ~ 2,
        drought[[1]] > qt[[3]] & drought[[1]] <= qt[[4]] ~ 3,
        drought[[1]] > qt[[4]] & drought[[1]] <= qt[[5]] ~ 4,
        drought[[1]] > qt[[5]] ~ 5
      )
    ) %>% select(recoded) * 4
  
  # final output (adding component rasters)
  final = (40 - geo) * 0.40 + drought * 0.20 + flood * 0.20
}

# final raster outputs (adding component rasters)
ta_final = vuln(ta_capacity)

lhz_final = vuln(lhz_capacity)

# joining vulnerability scores to traditional authorities and livelihood zones --------
message("zonal statistics: mean vunerability score...")
ta_2010$vun = exact_extract(as(ta_final, "Raster"), ta_2010, "mean")
lhz$vun = exact_extract(as(lhz_final, "Raster"), lhz, "mean")

# clipping traditional authorities for 2004 surveys -----------------------
ta_2004 = st_clip(st_transform(filter(ta, is.na(capacity_2004) == F), 3395), st_buffer(st_transform(lhz, 3395), .01)) %>%
  st_transform(4326)

# creating maps -----------------------------------------------------------
message("creating maps...")

lakes = st_as_sf(read_csv("data/lakes/major_lakes.csv")[, c("name", "the_geom")],
                 wkt = "the_geom",
                 crs = 4326) %>%
  st_geometry %>%
  st_union %>%
  st_sf %>%
  mutate(EA = "Major Lakes of Malawi")

ea = lhz %>%
  st_transform(3395) %>%
  summarize %>%
  st_geometry %>%
  st_intersection(st_geometry(st_transform(ta, 3395))) %>%
  st_transform(4326) %>%
  st_sf %>%
  mutate(EA = case_when(
    grepl("Reserve", ta[["NAME_2"]]) ==T | grepl("Park", ta[["NAME_2"]]) ==T ~ "National Parks and Reserves",
    T ~ "Missing Data")
  ) %>%
  rbind(lakes) %>%
  st_make_valid()

# adaptive capacity
map_2010 = ggplot() +
  geom_sf(data = ea,
          aes(fill = EA),
          color = NA) +
  geom_sf(
    data = ta_2010,
    aes(fill = capacity_2010_brks),
    color = "white",
    lwd = .2
  ) + scale_fill_manual(
    values = list(
      "Missing Data" = "#FFC389",
      "National Parks and Reserves" = "#D9EABB",
      "Major Lakes of Malawi" = "lightblue",
      "13.95 - 15.84" = "#333333",
      "15.84 - 17.13" = "#666666",
      "17.13 - 18.89" = "#999999",
      "18.89 - 21.36" = "#CCCCCC"
    )
  ) +
  scale_x_continuous(breaks = c(33,34,35,36)) +
  labs(title = "Adaptive Capacity Scores Based on 2010 DHS Surveys in 222 Traditional Authorities") +
  theme_minimal() +
  theme(legend.title = element_blank())

map_2004 = ggplot() +
  geom_sf(data = ea,
          aes(fill = EA),
          color = NA) +
  geom_sf(
    data = ta_2004,
    aes(fill = capacity_2004_brks),
    color = "white",
    lwd = .2
  ) +  scale_fill_manual(
    values = list(
      "Missing Data" = "#FFC389",
      "National Parks and Reserves" = "#D9EABB",
      "Major Lakes of Malawi" = "lightblue",
      "12.32 - 14.23" = "#333333",
      "14.23 - 15.4" = "#666666",
      "15.4 - 16.73" = "#999999",
      "16.73 - 18.52" = "#CCCCCC"
    )
  ) +
  scale_x_continuous(breaks = c(33,34,35,36)) +
  labs(title = "Adaptive Capacity Scores Based on 2004 DHS Surveys in 183 Traditional Authorities") +
  theme_minimal() +
  theme(legend.title = element_blank())

# traditional authority vulnerability
colors = mutate(
  ea,
  colors = case_when(
    EA == "Missing Data" ~ "#999999",
    EA == "National Parks and Reserves" ~ "#D9EABB",
    EA == "Major Lakes of Malawi" ~ "lightblue"
  )
)$colors

vun_map = ggplot() +
  geom_sf(data = ea,
          fill = colors,
          color = NA) +
  geom_stars(data = ta_final) +
  scale_fill_gradient(
    low = "#FFFF75",
    high = "#CF4611",
    breaks = c(9.968335,  17.99652),
    labels = c("Lower Vulnerability", "Higher Vulnerability"),
    na.value = "transparent",
    guide = "colourbar",
    limits = c(9.968335,  17.99652)
  ) +
  scale_x_continuous(breaks = c(33,34,35,36)) +
  labs(title = "Malawi Vulnerability to Climate Change") +
  theme_minimal() +
  theme(
    legend.title = element_blank(),
    axis.title.x = element_blank(),
    axis.title.y = element_blank()
  )

message("saving maps...")

save(map_2004, map_2010, vun_map, file = "outputs/maps.Rdata")

ggsave(
  "ac_2004.pdf",
  plot = map_2004,
  width = 8.5,
  height = 11,
  units = "in"
)
ggsave(
  "ac_2010.pdf",
  plot = map_2010,
  width = 8.5,
  height = 11,
  units = "in"
)
ggsave(
  "vulnerability.pdf",
  plot = vun_map,
  width = 8.5,
  height = 11,
  units = "in"
)

# outputs from gis analysis --------------------------------------------------------------

if ("mwir_rstr.gpkg" %in% list.files("outputs")) {
  file.remove("outputs/mwir_rstr.gpkg")
  message("deleting mwir_rstr.gpkg...")
}

message("saving mwir_rstr.gpkg...")
write_stars(
  ta_final,
  dsn = "outputs/mwir_rstr.gpkg",
  driver = "GPKG",
  options = c("RASTER_TABLE=ta", "APPEND_SUBDATASET=YES")
)
write_stars(
  lhz_final,
  dsn = "outputs/mwir_rstr.gpkg",
  driver = "GPKG",
  options = c("RASTER_TABLE=lhz", "APPEND_SUBDATASET=YES")
)

message("saving mwir_vctr.gpkg...")
write_sf(ta_2010, dsn = "outputs/mwir_vctr.gpkg", layer = "ta_2010")
write_sf(ta_2004, dsn = "outputs/mwir_vctr.gpkg", layer = "ta_2004")
write_sf(lhz, dsn = "outputs/mwir_vctr.gpkg", layer = "lhz")

message("done!")

} else {
  message("Necessary files not available for mwir.R to properly run")
}
