# Powershell Scripts

## 文件操作

将文件夹内，包含子文件夹内，所有log文件合并成一个：

```powershell
$rawPath = "D:\CaseLog\DiagnosticsLogs"; # 日志文件夹路径
$allFile = Get-ChildItem $rawPath -Include *.log -recurse; # 获取子文件夹内所有log文件
foreach ($file in $allFile)
{
Get-Content $file >> $rawPath\all.txt; # 将日志文件合并到一个txt文件中
}
```

将文件夹内，包含子文件夹内的所有PDF文件移动到同一文件夹内：

```powershell
$rawPath = "I:\knowledge\极客时间音频专栏已完结课20220201\015-趣谈Linux操作系统（完结）"; # 文件原路径
$allFile = Get-ChildItem $rawPath -Include *.pdf -recurse; # 获取子文件夹内所有文件
foreach ($file in $allFile)
{
Copy-Item $file -Destination "C:\Users\hangx\Desktop\20221204打印\趣谈Linux\" ; # 放到指定文件夹中 
}
```

