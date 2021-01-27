# Introduction to Julia and JuMP

Julia is a "high-level, high-performance dynamic programming language for technical computing", and JuMP is a library that allows us to easily formulate optimization problems and solve them using a variety of solvers.

## Preassignment - Install Julia and IJulia

The first step is to install a recent version of Julia. The current version is 1.5.3. Binaries of Julia for all platforms are available [here](https://julialang.org/downloads/).

IJulia is the Julia version of IPython/Jupyter, that provides a nice notebook interface to run julia code, together with text and visualization.

Install the IJulia package.
You can invoke the package manager in Julia by pressing `]` from the Julia REPL.
You can add IJulia with:
```
(v1.5) pkg> add IJulia
```
or in the normal Julia REPL:
```
julia> Pkg.add("IJulia")
```

## Preassignment - get familiar with the notebook

### What is a Jupyter Notebook?
- Jupyter notebooks are documents (like a Word document) that can contain and run code.
- They were originally created for Python as part of the IPython project, and adapted for Julia by the IJulia project.
- They are very useful to prototype, draw plots, or even for teaching material like this one.
- The document relies only on a modern browser for rendering, and can easily be shared.

You can start a notebook with:
```
julia> using IJulia
julia> notebook()
```
and navigate to the appropriate directory.

### Navigating the notebook
Click Help -> User Interface Tour for a guided tour of the interface.
Each notebook is composed of cells, that either contain code or text (Markdown).
You can edit the content of a cell by double-clicking on it (Edit Mode).
When you are not editing a cell, you are in Command mode and can edit the structure of the notebook (cells, name, options...)

- Create a cell by:
	- Clicking Insert -> Insert Cell
	- Pressing a or b in Command Mode
	- Pressing Alt+Enter in Edit Mode
- Delete a cell by:
	- Clicking Edit -> Delete Cell
	- Pressing dd
	- Execute a cell by:
	- Clicking Cell -> Run
	- Pressing Ctrl+Enter

Other functions:

- Undo last text edit with Ctrl+z in Edit Mode
- Undo last cell manipulation with z in Command Mode
- Save notebook with Ctrl+s in Edit Mode
- Save notebook with s in Command Mode
Though notebooks rely on your browser to work, they do not require an internet connection (except for math rendering).

### Get comfortable with the notebook
Notebooks are designed to not be fragile. If you try to close a notebook with unsaved changes, the browser will warn you.
Try the following exercises:

#### Close/open
1. Save the notebook
2. Copy the address
3. Close the tab
4. Paste the address into a new tab (or re-open the last closed tab with Ctrl+Shift+T on Chrome)

*The document is still there, and the Julia kernel is still alive! Nothing is lost.*

#### Zoom
Try changing the magnification of the web page (Ctrl+, Ctrl- on Chrome).

*Text and math scale well (so do graphics if you use an SVG or PDF backend).*

#### MathJax
1. Create a new cell, and select the type Markdown (or press m)
2. Type an opening \$, your favorite mathematical expression, and a closing \$.
3. Run the cell to render the $\LaTeX$ expression.
4. Right-click the rendered expression.

#### REPL shortcuts
1. Create a new cell
2. Experiment with typing `\pi`, `\approx`, `\alpha` and press your Tab key to
   autocomplete into special characters, see what values are returned
3. Experiment with typing `?<function name>` to get help for a function, e.g. `?print`
4. Experiment with typing `;<shell command>` to switch to command line, e.g. `;pwd`
5. Try the shortcuts `Ctrl` / `command` + `/` to comment or `[` / `]` to tab

## Preassignment - Install libraries

### Install Gurobi

Gurobi is commercial software, but they have a very permissive (and free!) academic license. If you have an older version of Gurobi (>= 5.5) on your computer, that should be fine.

- Go to [gurobi.com](http://www.gurobi.com) and sign up for an account
- Get an academic license from the website (section 2.1 of the quick-start guide)
- Download and install the Gurobi optimizer (section 3 of the quick-start guide)
- Activate your academic license (section 4.1 of the quick-start guide)
- you need to do the activation step while connected to the MIT network. If you are off-campus, you can use the [MIT VPN](https://ist.mit.edu/vpn) to connect to the network and then activate (get in touch if you have trouble with this).
- Test your license (section 4.6 of the quick-start guide)

### Install the Gurobi and JuMP in Julia

Installing packages in Julia is easy with the Julia package manager. Just open Julia and enter the following command:

```jl
using Pkg
Pkg.add("Gurobi")
```

If you don't have an academic email or cannot get access for Gurobi for another reason, you should be able to follow along with the open source solver GLPK for much of the class. To install, simply do.

```jl
Pkg.add("GLPK")
```

Also install the JuMP package:

```jl
Pkg.add("JuMP")
```

## Install other packages we will use
Run `] add <package name>` to add the following packages:
1. BenchmarkTools
2. CSV
3. DataFrames
4. Plots
5. Ipopt
6. ForwardDiff

Run `using <package name>` in the Julia REPL (e.g. `using JuMP`) to test
there are no errors with the packages you added.
Upload a screenshot of the output.

## Other packages for use on session 7 Advanced optimization in JuMP:
In addition to the installation instructions from the previous session, we will use the following packages:

1. LinearAlgebra
2. Test

No screenshot need to be submitted on Canvas for this pre-assignment.

## Questions?
Email lyna@mit.edu or lkap@mit.edu
