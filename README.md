# RTLS_CaseStudy
Real-Time Location System Case Study

## From Slater's Wall Post
For clarity, the first case study (Generally due week 3) is here: https://2ds.datascience.smu.edu/mod/assignment/view.php?id=21814.
The data is here:
http://rdatasciencecases.org/Data.html

## Basics

Will be using KNN to determine the location of the data (trying to predict which neighbor based on the floor plan). 

In the analysis presented in Nolan and Lang, the access points were matched to their locations, and the decision was made to keep the access point with MAC address 00:0f:a3:39:e1:c0 and to eliminate the data corresponding to MAC address 00:0f:a3:39:dd:cd. **Conduct a more thorough data analysis into these two MAC addresses including determining locations by using data corresponding to both MAC addresses.**

## Questions to Answer
1. Which of these two MAC addresses should be used and which should not be used for RTLS?
2. Which MAC address yields the best prediction of location?
3. Does using data for both MAC addresses simultaneously yield more, or less, accurate prediction of location? (Note: this portion is derived from Exercise Q.9 in Nolan and Lang.)

## Other Approaches
In addtion to KNN also implement the method detailed below:

* One simple alternative approach is to use weights on the received signal strength, where the weight is inversely proportional to the “distance” from the test observation.  This allows for the “nearest” points to have a greater contribution to the k-nearest neighbor location calculation than the points that are “further” away.  **ALSO A KNN APPROACH BUT WITH WEIGHTED VARIABLES**

## Deliverable
* IPython Notebook with code and output and graphics for all work
* Include an introduction to explaine the case study, the approach used, and output. 
* List all references, including the book
