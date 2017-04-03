

## How to debug

Introduction for run and how to debug for Kuri.
Let's clone this repository and open the **Kuri.xcodeproj**.

### Run in xcodeproject]

When preparation are clone and open.
You can run **Kuri.xcodeproj**. 
But having the also this message on console.

```
ErrorType missingArgument("Please command name Kuri XXXX") description: Please command name Kuri XXXX
Program ended with exit code: 1
```

Why Error message?
Because Kuri needs set some **Argument** and **Environtment** when debug on run time.

### Environtment and Argumenets

Explain what to do about the environment and argument.
You can set **Arguments passed on launch** and **Environtment variables** in Xcode.
Please open **Edit Scheme** window.
`Xcode menu` > `Product` > `Scheme` > `Edit Scheme`

<img width="320px" src="https://cloud.githubusercontent.com/assets/10897361/24594231/faea3e0c-1865-11e7-9ab5-39da7007dcba.png" />

And you should set these.

#### Example

<img width="320px" src="https://cloud.githubusercontent.com/assets/10897361/24593962/39d16530-1863-11e7-9db7-fe573f21bc74.png" />

**Arguments Passed On Launch** set for option when kuri command.  

In the above example.  
**Arguments Passed On Launch** set `generate Hoge`
it has the same meaning as this.

```
$ kuri generate Hoge
```

**Environtment variables** set for environment when run time on kuri.
You should set key and value of **WorkingDirectory**.
**WorkingDirectory** want to have target `XXXX.xcodeproj` file.
In the above example, **WorkingDirectory** is submodule in Kuri in my local.
Please rewrite this as absolute path in each environment

So, If you run the Kuri.xcodeproj, that generate **Hoge** in your **WorkingDirectory**project.
If successful, you can debug to use breakpoint, print, and so.

I hope nice PR!!.


