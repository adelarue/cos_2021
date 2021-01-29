Because this session is technically held after the end of IAP, the pre-assignment is OPTIONAL and there is nothing to turn in on Canvas.

This final session is specifically targeted at students affiliated with Sloan or the ORC, who have access to the Engaging cluster. If you are not affiliated with either organization, you will not be able to live-code along during the session, but the session is designed so you can follow along anyway, and the topics we cover generalize to the use of many computing clusters.

[Sloan/ORC only beyond this point] In order to login, you first need to request an account by emailing stshelp@mit.edu.

Once your account has been created, login to engaging.
> If you're using Mac/linux, type `ssh <user_name>@eosloan.mit.edu` into the terminal and enter your password.
> If you're using Windows, you will need to use Putty or another command-line application. Set the host name to `eosloan.mit.edu` and click "Open".

In this session, we will use julia on Engaging, and we need to install a few packages. Once you've logged into Engaging, run the following commands (don't worry if you don't understand what we're doing here - we'll discuss during the session):
  1. `srun --pty --partition=sched_any_quicktest --cpus-per-task=1 --mem=2G bash` (Note: this may take a few minutes depending on how busy the cluster is)
  2. `module load julia/1.2.0`
  3. `module load sloan/python/modules/2.7` (very important to include this line)
  4. `julia`
(At this point, a julia session will open, so we're going to install the packages we need. This will take a few minutes.)
  5. Enter the following commands:
```julia
julia> using Pkg

julia> Pkg.add("ScikitLearn")

julia> exit()
```
You can also use the preferred Julia package manager syntax: `julia> ] add ScikitLearn` instead of `using Pkg` and `Pkg.add("ScikitLearn")`.

  6. Reopen the julia session: `julia`
  7. Precompile the ScikitLearn package we just installed (may take a few mins) as follows:
```julia
julia> using ScikitLearn

julia> @sk_import ensemble:RandomForestClassifier
```
  8. Now install the other packages we need with the following commands:
```julia
julia> using Pkg

julia> Pkg.add("DataFrames")

julia> Pkg.add("CSV")

julia> Pkg.add("JLD2")

julia> using DataFrames, CSV, ScikitLearn, JLD2

julia> exit()
```
  9. Disconnect from engaging by entering `exit`, then `logout`.

Note (IGNORE if step 7 did not give you an error): if you experience an error message at step 7, exit julia, then enter `exit` in the command line to return to the head node. Repeat steps 1-4. Then try the following commands:
```julia
julia> using Pkg

julia> ENV["PYTHON"] = "/home/software/python/2.7.14/bin/python"

julia> Pkg.build("PyCall")

julia> exit()
```
Now try steps 6-9 again.

Questions? Email adelarue@mit.edu.
