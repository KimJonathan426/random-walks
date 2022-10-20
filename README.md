# random-walks

## Project Objectives
The objective of the “RANDOM” MATLAB project was to investigate and compare the
relationship between random walks and diffusion processes. The idea of “random walks” was
originally proposed by Karl Pearson in 1905. In a letter to Nature, he gave a simple model to
describe a mosquito infestation in a forest. At each time step, a single mosquito would move at
a xed length at a randomly chosen angle. Pearson wanted to know the distribution of said
mosquitos after a set time and number of steps. Similarly, The goal of this project is to code a
GUI program that can be used to simulate and plot random walks in both the 2nd and 3rd
dimensions and then compare the results to the diffusion equation. The GUI should allow the
user to input a time vector, number of particles, problem dimensions, and target diffusion
coefficient. Upon the execution of the run button, the program should compute and display the
results as well as a normalized histogram of the number of particles in groups of distance from
the origin. This information will be used to show the equivalence between both types of
processes with varying values of diffusion and particles in different problem dimensions.

## Methods
The GUI was initially set up via a figure, axes, and multiple uicontrol settings to set the
foundation of the figure layout. Each uicontrol and axes was written out individually in order to
specify positions and unique tags of each feature accordingly. These uicontrol handles include
text boxes for a user input time vector, diffusion coefficient, number of particles, 3D option, and
their respective labels. Parts of the function fows_gui3 under MATLAB_GUI_GUIDE were
utilized to set these axes in the figure to display the plots on only the certain tagged axes. A
boiler plate single callback was utilized by using a for loop to identify the figure’s handles to
eventually be called through the main callback function. Once the main function was
established, a switch in the case the run button is pressed initiates the program based on the
information given. First, all notable data/information is processed and stored in static variables.
Data from textboxes are stored by evaluating the handles given appropriate tags. The entirety of
the code lies inside an if else conditional statement that have additional for loops nested inside.
The GUI is defaulted to run in two dimensions if not otherwise stated. The checkbox condition
was created on the basis of the function usgsplot2 under the file MATLAB_GUI_PROG. If the
checkbox was checked, a logical value would be assigned to that handle automatically. The if
condition is satisfied when the value of the handle exists (true). Once the programs path is
determined, it runs one of two seemingly identical codes. The code runs the rndwlk2D or
rndwlk3D function for the original random walks and plots the result (x) number of time based on
the number of particles. The only difference between the two function scripts is that rndwlk3D
applies an additional random vertical angle to simulate the z axis. Lastly, the code of a
normalized histogram of displacement of particles provided by Dr. Montas himself was altered to
fit our variables and parameters for the project. The parameters for the histogram was set to 3
(ntp = 3). This essentially divides the time vector by 3 and increases by that same interval until
the end. The corresponding time and radial positions are grouped and normalized by the
number of particles then plotted with reference to the diffusion equation solution. Research was
conducted to identify the differences of the diffusion equation in two and three dimensions
(MIT-Threetheory). This is the only difference between the two histogram codes.

## Project Results
GUI Foundation/Layout:
The results of the project in general represent the objectives of the project at hand. In
more detail...

<p align="center">
  <img src='https://user-images.githubusercontent.com/100963461/197039034-8613e824-94c3-4a68-8a27-179ca63b490c.JPG' alt='random walks empty gui'/>
</p>

The result of the uicontrol and axes handles in the figure can be seen in figure 1. The figure itself will open 100
units from the left and 100 units from the bottom of the user’s screen. The figure is 800 units in width and 850 units in
height. The position of the axes will stay consistent but change accordingly to the plots of histograms or random walks as
called. The GUI allows for user input of a time vector, particle(s), diffusion coefficient, and 3-D option. The user
may run the program when all sufficient data has been provided. The data provided must be logical and within
certain parameters. The time vector is produced by colon form and must remain so. Particles must be equal to or more
than 1. The diffusion coefficient should not be too large to optimize data, and cannot be equal to 0. The GUI is
defaulted to run in 2D but the user is given the option to check mark the box labeled “Yes!” to
change this setting. After all the parameters are set, the user may push the RUN button to
proceed with displaying the results of the rest of the code.

### Two-Dimensional and Three Dimensional Results:
The premise behind both results are fairly similar. Both codes use very similar code
except to where the angles and equations are altered from 2D to 3D. The results of both figure 2
and figure 3 represent that of the dispersion of 200 particles in space with a diffusion coefficient
of 0.0001. The particles travel in random angles starting from the origin for a duration of 500
seconds, capturing the dispersion every second (500 time steps). Different colors are
automatically assigned to each individual particle path. To clarify, the results of the two figures
use the same parameters but the diffusion is randomized each run so no two results will be the
same in two dimensions or three dimensions.

<p align="center">
  <img src='https://user-images.githubusercontent.com/100963461/197039139-b00b76cd-f56c-44fb-804b-378e8c05593a.JPG' alt='random walks results in 2d'/>
  <img src='https://user-images.githubusercontent.com/100963461/197039149-f27ab624-fca9-4be5-89db-0309716d2287.JPG' alt='random walks results in 3d'/>
</p>

Each histogram (increasing times from left to right) is a snippet of the particle distribution
of displacement from three equally spaced time from start to end (including the end). As time
starts the distribution is approaching that of universal diffusion given by the diffusion equation.
The more time that progresses, the histogram is able to reach equilibrium and fluctuate above
and below the universal diffusion of particles.
The bars in the histogram represent particles of different groups of distance from the
origin (radial position) and their relative concentrations. This is a collective result of the entirety
of the particles. However, without the inclusion of the diffusion equation solution (curve), it would
be hard to visualize the meaning of the result of the histogram. It can be seen that the results of
the random walks match that of the diffusion equation. There may be a few outliers in some of
the histogram bars but can be noted as insignificant and just variability in the run. Results may
vary given different parameters. As this is a collective result of many particles and time steps,
reducing the parameters to less time steps or less particles will result in a result that may not
match the diffusion equation. A diffusion equation too large will also result in a histogram that is
significantly larger than the distribution of distance of the diffusion equation.


## Summary and Future Work
Our MATLAB program investigated the relationship between random walks and
diffusion. The program creates an aesthetically pleasing Graphical User Interface (GUI) that
performs random walks in both two dimensions and three dimensions depending on the
preference of the user. The specific dimension can be decided by either checking or
unchecking a “Yes!” box labeled “Change to 3-D?” The default dimension is two dimensions,
and is only changed to three dimensions if that box is checked. Users also set the time vector,
number of particles, and the diffusion coefficient via the editable text boxes provided and then
click on the “RUN” push button to display the result. The program displays both the computed
random walk values on a set of axes as well as normalized histograms of the number of
particles of groups of distances from the origin at times between the start and end of the time
vector in intervals of thirds.
There were many trends and patterns we discovered when running our program at
various times with different combinations of parameters. We noticed that after a large number
of steps, the statistical properties of random walks tended toward universal distribution. Some
of the parameters we tested were the distances of the two-thousand steps chosen from a
Cauchy distribution. We deciphered that the walk mostly takes small steps, but occasionally
makes very large jumps, comparable to the total displacement. This is rather different from the
case of Pearson’s walk, where the step size is constant and normal diffusion occurs. We also
discovered some ways to achieve anomalous diffusion including utilizing highly non-uniform
step distributions, strong correlations between steps, and interactions between multiple random
walkers. In such cases, the continuum limit is more subtle and leads to various generalizations
of the diffusion equation. (Rycroft, C. H., & Bazant, M. Z. 2005, February 1)
In terms of coding, we learned how to persevere through our suffering to debug, alter, and code
a GUI that is representative of this concept.
This random diffusion walks concepts is very important due its potential for an
innumerable amount of applications in a wide range of disciplines. In financial economics, the
"random walk hypothesis" is used to model shares prices and other factors. Empirical studies
found some deviations from this theoretical model, especially in short term and long term
correlations. In population genetics, random walk describes the statistical properties of genetic
drift. In physics, random walks are used as simplified models of physical Brownian motion and
diffusion such as the random movement of molecules in liquids and gases. In polymer physics,
random walk describes an ideal chain. It is the simplest model to study polymers. In other fields
of mathematics, random walk is used to calculate solutions to Laplace's equation, to estimate
the harmonic measure, and for various constructions in analysis and combinatorics. These are
some of areas where the “Random Walk” concept can continue to be explored.


## Works Cited
Codling, E. A., Plank, M. J., & Benhamou, S. (2008, April 15). Random walk models in biology. Retrieved
December 17, 2018, from https://royalsocietypublishing.org/doi/full/10.1098/rsif.2008.0014#sec-13
Histogram. (n.d.). Retrieved December 17, 2018, from
https://www.mathworks.com/help/matlab/ref/matlab.graphics.chart.primitive.histogram.html
MIT-THREETHEORY. (n.d.). Retrieved December 18, 2018, from
http://web.mit.edu/1.061/www/dream/THREE/THREETHEORY.PDF
Rycroft, C. H., & Bazant, M. Z. (2005, February 1). Lecture 1: Introduction to Random Walks
and Diffusion. Retrieved December 17, 2018, from
https://ocw.mit.edu/courses/mathematics/18-366-random-walks-and-dif usion-fall-2006/lecture-notes/lec
01.pdf
Montas, H.J., 2018. BIOE241 Lecture Notes. University of Maryland at College Park, College Park, MD,
20742.
