# Machine Learning in Python

In this session, we will introduce the Python programming language, Jupyter notebooks, and basic machine learning in Python. By the end of this session, you will be able to run standard machine learning models for regression and classification tasks in Python. We'll use scikit-learn, a core data science library that covers everything from data preprocessing to model evaluation. We will use the same AirBnB listings dataset from last week's R sessions.


## Pre-assignment 1: Keeping current (again!)

To ensure that you have the most current versions of all files, please fire up a terminal, navigate to the directory into which you cloned the full set of materials for the course, and run `git pull`.  (Refer back to Session 1 if you're having trouble here.)

During class, we will work through the ML in Python notebook. The *class* version has unsolved exercises for you to work through after class. The *complete* version includes solutions to all exercises. 

## Pre-assignment 2: Set up Python and Jupyter

We will be using `Python` for our machine learning tasks. We will use Jupyter notebooks as our interface for writing and executing `Python` code. 

**Step 1: Install Anaconda**: Anaconda offers a Python distribution that pre-installs many of the packages and tools that you will need, including Jupyter. Go to the [Anaconda website](https://www.anaconda.com/products/individual) and download the distribution for your operating system. Follow the installation instructions.


**Step 2: Open Jupyter**: 

Open your terminal and try to open your first Jupyter notebook:
```
> jupyter notebook
```
If all went well, you should now be looking at a file navigation system in your browser. Let's create a notebook:
1. Navigate through to the `cos_2021` directory on your computer, and go to `4_modeling_and_ml`.  
2. In the upper-right corner, click the "New" dropdown and select "Python 3". You have just created a Jupyter notebook!


Now let's make sure that Python is working: Click into the first cell and type:
```
import pandas as pd
df = pd.read_csv('../data/listings.csv')

from sklearn.model_selection import train_test_split 
train, test = train_test_split(df, train_size = 0.75)
```
You can execute the code by typing "Shift+Enter" while in the cell, or by clicking the "Run" button on the top toolbar.

This should load the listings data in Python and split it into a training (75%) and testing (25%) set. Notice that you didn't have to explicitly install the `pandas` or `sklearn` libraries; many of the libraries that you will use are pre-installed through Anaconda.

**Please submit a screenshot of the Jupyter notebook output to the Pre-Assignment 4 Page on the course Canvas page. If you run into any issues, email [Holly Wiberg] (hwiberg@mit.edu).**


## Additional Resources

Like R, Python is *super* well-documented on the internet! Here are some helpful links:

#### Python basics
- [Intro to pandas](https://github.com/jvns/pandas-cookbook): `pandas` is similar to `tidyverse` in R. It's the library that we will use to interact with data (loading, aggregation, filtering, etc.). This is a great tutorial for learning pandas syntax and its various capabilities.
- [Intro to scikit-learn](https://scikit-learn.org/stable/tutorial/index.html): The scikit-learn site has several tutorials for completing different data science tasks, as well as complete documentation.
- [Python syntax cheat sheets](https://ehmatthes.github.io/pcc_2e/cheat_sheets/cheat_sheets/)
- R/Python cheat sheets: [RPubs](https://www.rpubs.com/Bentley_87/542213), [towardsdatascience](https://towardsdatascience.com/cheat-sheet-for-python-dataframe-r-dataframe-syntax-conversions-450f656b44ca). If you are familiar with R and want to get started in Python (or vice versa), these sites compare the basics in both languages.


#### Jupyter notebooks 
- [Jupyter interface walkthrough](https://realpython.com/jupyter-notebook-introduction/): This blog goes through the Jupyter interface and functionality. We'll go over this in class too, but this covers the basics.
- [Jupyter documentation](https://jupyter-notebook.readthedocs.io/en/stable/notebook.html)
