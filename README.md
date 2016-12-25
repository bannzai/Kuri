# Kuri
**Kuri** is a tool that automatically generates necessary code for _iOS CleanArchitecture_ and imports it into Xcode project.

#### Usage tutorial.
I gave youtube a video explaining how to use **Kuri** so please refer also [here](https://www.youtube.com/watch?v=Ae9ETnSgENY&feature=youtu.be).

## What is *CleanArchitecture*?
Reference source [here](https://8thlight.com/blog/uncle-bob/2012/08/13/the-clean-architecture.html)

#### Features of *CleanArchitecture* are as follows.
1. Independent of Frameworks.
2. Testable.
3. Independent of UI.
4. Independent of Database.
5. Independent of any external agency.

<img width="320px" src="https://cloud.githubusercontent.com/assets/10897361/21470324/24bf3102-cac7-11e6-8d70-1a6e8623407b.jpeg"/>

## Why Kuri?
*CleanArchitecture* is a very wonderful way of thinking.
In the case of products operated in the medium to long term, profits will be large.
However, it is not without drawbacks.
The amount of code that one writes is large.

So, I thought about making a tool to automatically generate code from some templates. That is **Kuri**.

### Components
I believe that the following concepts are necessary in iOS CleanArchitecture.
**Kuri** will arrange the mechanism for it.
- **Entity** -  Value object.
- **DataStore** -  Data store for Entity.
- **Repository** -  Operation Datastore interface.
- **UseCase** -  Application operation. translate CRUD operation to repository.
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
The "Kuri.yml" and "KuriTemplate" directories are created unser the current directory.

### generate
The form of the *generate* command basically looks like this
`kuri generate "MyName"`.
After Executing *generate* command, you can comfirm to want to append files and directories for *MyNameEntity*, *MyNameRepository*, *MyNameView* and so on into Xcode project.

Instructions with options [here](./Documents/generate.md).

## Customize
**Kuri.yml** and **KuriTemplate** can be customized respectively.

- [Kuri.yml](./Documents/yaml.md)
- [KuriTemplate](./Documents/template.md)


## Installation
Now only manual installation method is available.
### Manual
1. Download **Kuri** `git clone git@github.com:bannzai/Kuri.git`
2. Execute `git submodule init` and `git submodule update`.
3. Open **Kuri.xcodeproj** and build it.
4. Confirm for generated command line product name **kuri**
Like this
 ![](https://cloud.githubusercontent.com/assets/10897361/21470539/3703c490-cad1-11e6-9147-55dd8fcde4a2.png)
5. Copy **kuri**.(location of **kuri** by **show in finder** right click on the **kuri** icon).
![](https://cloud.githubusercontent.com/assets/10897361/21470544/7b741f44-cad1-11e6-9cf8-d80b02eab7b6.png)
6. Paste it where you can execute from the CLI.

You can now run the **kuri** command.

## License
*Kuri* is available under the MIT license. See the LICENSE file for more info.
