# MNN-design

This repository contains the data collected as part of a research project from the Flexible Research Group to use Mechanical Neural Networks to design passive metamaterials

## BeamData

The folder BeamData contains the data collected from performing linear compression tests on the passive beam designs used as part of this project, using an INSTRON 5966 universal testing machine, with a 500 N INSTRON load cell. 

The subfolders MaxStiffness, MedStiffness, and ZeroStiffness refer to the three separate beam designs. 

Within each subfolder, the CSV file for each test has been renamed from 1 to 10 to respect chronological order.

## BeamCADs

The folder BeamCADs contains the CAD files for each beam design.

The subfolders MaxStiffness, MedStiffness, and ZeroStiffness refer to the three separate beam designs. 

For 3d-printed parts, the print files used for the respective printer types are included in subfolders labelled as the polymer types to be employed for each.

## MNNLearning

The folder MNNLearning contains the data collected from running the mechanical neural network prototype located in the Flexible Research Group lab space to optimize towards the Spreading and Pinching behaviors.

The subfolders Spreading and Pinching correspond to the two behaviors learnt by the mechanical neural network.

Within each subfolder, the MATLAB Data files include the structured datasets for the optimization.

Within these structures, each field indicates the following:
- arrayPar: calibration constants
- dispHist: displacement values of each node, in order of time; each 140 rows correspond to one generation of the GA algorithm employed
- errorHist: MSE and absolute error for each GA evaluation; each 140 rows correspond to one generation of the GA algorithm employed
- goodDisps: displacements at last logged run
- sysPar: voice coil control parameters
- testNum: number of evaluations
- testpar: description of the target behavior
- timeHist: time stamps for all evaluations
- triggerPar: sensor parameters
- xHist: stiffness of each beam for each GA evaluation; each 140 rows correspond to one generation of the GA algorithm employed

## BuiltMetamaterials

The folder BuiltMetamaterials contains the data collected on the passive metamaterials built using the beam arrangement solved by the mechanical neural network.

The subfolders Spreading and Pinching correspond to the two built metamaterials assemblies.

Within each subfolder, the CSV files contain the time series data as collected by the camera trackers, and the workspace MATLAB data files include the parameters used in post-processing.

The following list describes the relevant variables:
- camerawidth, bottom_bottomgap, bottom_gap, bottom_topgap, top_bottomgap, top_gap, top_topgap describe the geometry of the mounting components in the camera system; the prefixes top_ and bottom_ indicate the relevant camera systems for node 1 and node 2, respectively; the _topgap and _bottomgap suffixes indicate the distances between the cameras and the vertical mounting assembly; the _gap suffixes indicate the pitch height of the cameras
- theta1, theta2 describe the roll angles in the camera for the two nodes
- CoMArray is the raw data, as included in the CSV file in the same folder
