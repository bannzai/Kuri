### Properties
- **Target** - Your project target name.
- **TemplateRootPath** - Read template directory root path.
- **ProjectRootPath** - Your project root directory path.
- **ProjectFileName** - Your project file name.
- **GenerateRootPath**  - You can specify the root directory path you want to generate.
- **CustomSuffix** - You can define the end of the name of the file and structure you name.

### Customized
You can customize **Kuri.yml** according to the following rules.

If you run the *setup* command the contents of **Kuri.yml** should look something like this.

```
TemplateRootPath: ./
ProjectRootPath: ./
ProjectFileName: KuriDemo.xcodeproj
GenerateRootPath: ./KuriDemo/
Target: KuriDemo

View:
 CustomSuffix: ViewController
```

What is written at the top level applies to any Component.

```
View:
 CustomSuffix: ViewController
```
This way of writing only applies to that component.
For example, if you change **CustomSuffix**, the suffix of `View` file will change as well.

It can also be divided by Interface or Implement.
In this example it is made to be the same as the result of the *setup* command.

```
TemplateRootPath: ./

Entity:
 Interface:
  ProjectFileName: KuriDemo.xcodeproj
  ProjectRootPath: ./
  GenerateRootPath: ./KuriDemo/
 Implement:
  ProjectFileName: KuriDemo.xcodeproj
  ProjectRootPath: ./
  GenerateRootPath: ./KuriDemo/
DataStore:
 Interface:
  ProjectFileName: KuriDemo.xcodeproj
  ProjectRootPath: ./
  GenerateRootPath: ./KuriDemo/
 Implement:
  ProjectFileName: KuriDemo.xcodeproj
  ProjectRootPath: ./
  GenerateRootPath: ./KuriDemo/
Repository:
 Interface:
  ProjectFileName: KuriDemo.xcodeproj
  ProjectRootPath: ./
  GenerateRootPath: ./KuriDemo/
 Implement:
  ProjectFileName: KuriDemo.xcodeproj
  ProjectRootPath: ./
  GenerateRootPath: ./KuriDemo/
UseCase:
 Interface:
  ProjectFileName: KuriDemo.xcodeproj
  ProjectRootPath: ./
  GenerateRootPath: ./KuriDemo/
 Implement:
  ProjectFileName: KuriDemo.xcodeproj
  ProjectRootPath: ./
  GenerateRootPath: ./KuriDemo/
Translator:
 Interface:
  ProjectFileName: KuriDemo.xcodeproj
  ProjectRootPath: ./
  GenerateRootPath: ./KuriDemo/
 Implement:
  ProjectFileName: KuriDemo.xcodeproj
  ProjectRootPath: ./
  GenerateRootPath: ./KuriDemo/
Model:
 Interface:
  ProjectFileName: KuriDemo.xcodeproj
  ProjectRootPath: ./
  GenerateRootPath: ./KuriDemo/
 Implement:
  ProjectFileName: KuriDemo.xcodeproj
  ProjectRootPath: ./
  GenerateRootPath: ./KuriDemo/
Presenter:
 Interface:
  ProjectFileName: KuriDemo.xcodeproj
  ProjectRootPath: ./
  GenerateRootPath: ./KuriDemo/
 Implement:
  ProjectFileName: KuriDemo.xcodeproj
  ProjectRootPath: ./
  GenerateRootPath: ./KuriDemo/
View:
 Interface:
  ProjectFileName: KuriDemo.xcodeproj
  ProjectRootPath: ./
  GenerateRootPath: ./KuriDemo/
  CustomSuffix: ViewController
 Implement:
  ProjectFileName: KuriDemo.xcodeproj
  ProjectRootPath: ./
  GenerateRootPath: ./KuriDemo/
  CustomSuffix: ViewController
Wireframe:
 Interface:
  ProjectFileName: KuriDemo.xcodeproj
  ProjectRootPath: ./
  GenerateRootPath: ./KuriDemo/
 Implement:
  ProjectFileName: KuriDemo.xcodeproj
  ProjectRootPath: ./
  GenerateRootPath: ./KuriDemo/
Builder:
 Interface:
  ProjectFileName: KuriDemo.xcodeproj
  ProjectRootPath: ./
  GenerateRootPath: ./KuriDemo/
 Implement:
  ProjectFileName: KuriDemo.xcodeproj
  ProjectRootPath: ./
  GenerateRootPath: ./KuriDemo/
```
