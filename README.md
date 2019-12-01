# Kuri

**Kuri** is a tool that automatically generates necessary code and imports it into Xcode project.

#### Usage tutorial.
I gave youtube a video explaining how to use **Kuri** so please refer also [here](https://www.youtube.com/watch?v=Ae9ETnSgENY&feature=youtu.be).

## Why Kuri?
I was use [Clean Architecture](https://8thlight.com/blog/uncle-bob/2012/08/13/the-clean-architecture.html) for my product.
*Clean Architecture* is a very wonderful way of thinking.
But very very written some boiler plate code and many many file create and import xcode.
This is so hard.

So, I thought about making a tool to automatically generate code from some templates. 

<img width="320px" src="https://cloud.githubusercontent.com/assets/10897361/21470324/24bf3102-cac7-11e6-8d70-1a6e8623407b.jpeg"/>

But Kuri is not only use *Clean Architecture*.
You can use VIPER, MVVM... and your own architecture.

### Components(Default)
I believe that the following concepts are necessary in iOS CleanArchitecture.
**Kuri** will arrange the mechanism for it.
- **Entity** -  Value object.
- **DataStore** -  Data store for Entity.
- **Repository** -  Operation Datastore interface.
- **UseCase** -  Application operation. translate and CRUD operation to repository.
- **Translator** -  Translate Entity to Model or Model to Entity.
- **Model** - Converted Entity for UI.
- **Presenter** -  Event handle for View.
- **View** -  Drawing UI.
- **Wireframe** -  Control transition of View.
- **Builder** -  Make a View with Dependency Injection.

## Usage
When using "Kuri" Two preparations are necessary.
- Kuri.yml file.
- KuriTemplate directory.

But using *setup* command will prepare these two.

### setup
In project file root directory.
You can type `kuri setup` and press enter in CLI tool.
The "Kuri.yml" and "KuriTemplate" directories are created under the current directory.

### generate
The form of the *generate* command basically looks like this
`kuri generate "MyName"`.
After Executing *generate* command, you can comfirm to want to append files and directories for *MyNameEntity*, *MyNameRepository*, *MyNameView* and so on into Xcode project.

e.g
Execute on terminal where project root directory.
```
$ kuri generate Kuri
```
![](https://cloud.githubusercontent.com/assets/10897361/21471548/01c91b3a-cafa-11e6-8f33-58c2c8b3c68e.png)

Instructions with options [here](./Documents/generate.md).


## Supported file
- `.swift`
- `.storyboard`
- `.xib`

## Customize
**Kuri.yml** and **KuriTemplate** can be customized respectively.

- [Kuri.yml](./Documents/yaml.md)
- [KuriTemplate](./Documents/template.md)

and you can check [KuriDemo](./KuriDemo/)'s templates.

## Installation
### Mint (Recommended)
[Mint](https://github.com/yonaskolb/Mint) is a package manager for created by swift package manager executable libraries. 
`$ mint install bannzai/kuri

### Manual
1. Download **Kuri** from [latest release version](https://github.com/bannzai/Kuri/releases)
2. Copy **kuri** and paste it where you can execute from the CLI. (e.g. `/usr/local/bin/`. Every directory is okay if the path passed.)

You can now run the **kuri** command.

### How to debug
If you want to debug for **Kuri**.
You should see [here](./Documents/debug.md).

## License
*Kuri* is available under the MIT license. See the LICENSE file for more info.
