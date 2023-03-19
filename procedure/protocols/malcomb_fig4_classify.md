Ordinal data from figure 4 was digitized in ta_v_fig4.gpkg with QGIS using the following
procedure:

1.  Copy image from the original publication `pdf` file using Adobe
    Acrobat Pro
2.  Paste the image and save as a `.png` file with pixel dimensions 1982
    by 2811
3.  Use QGIS 3.26.3 Georeference the map image to match `ta_v.gpkg`
    using WGS 84 geographic coordinates (epsg:4326). Use linear
    georeferencing with points in
    `malcomb_fig4.png.points`
4.  Make internal buffer to reduce the noise from boundary line
    symbology.
    1.  Project `ta_v` to UTM 36S epsg:32736: `ta_v_fig4.gpkg:utm36s`.
    2.  Calculate an internal buffer of `-600m`:
        `ta_v_fig4.gpkg:utm36s`.
    3.  Project back to WGS 84 epsg:4326: `ta_v_fig4.gpkg:buffer_wgs84`.
5.  Extract the average and standard deviation of the original map's
    red, green, and blue bands for each traditional authority using the
    zonal statistics algorithm: `ta_v_fig4.gpkg:r`, `ta_v_fig4.gpkg:rb`
    and `ta_v_fig4.gpkg:rbg`
6.  Join the zonal statistics results to the `ta_v` layer by the `ID_2`
    attribute: `ta_v_fig4.gpkg:ta_v_fig4`
7.  Classify the results in a new field `orac` (original adaptive
    capacity) using the field calculator and `CASE` statements, choosing
    break points that classify most traditional authorities correctly.
8.  Visually inspect results and edit the `orac` attribute for any
    mis-classified area.
9.  The original map contains data in six conservation areas, noted with
    digitized point features in `ta_v_fig4.gpkg:fig4_errors`. Other
    areas are coded as follows:

| code | description                                        |
|:----:|:--------------------------------------------------:|
|  -3  | polygon too small to discern color or pattern fill |
|  -2  | white fill not matching any legend item            |
|  -1  | pattern fill for "missing DHS data"                |
|  1   | lowest adaptive capacity                           |
|  2   | ...                                                |
|  3   | ...                                                |
|  4   | highest adaptive capacity                          |
