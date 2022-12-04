$rawPath = "I:\knowledge\极客时间音频专栏已完结课20220201\015-趣谈Linux操作系统（完结）"; # 文件原路径
$allFile = Get-ChildItem $rawPath -Include *.pdf -recurse; # 获取子文件夹内所有文件
foreach ($file in $allFile)
{
Copy-Item $file -Destination "C:\Users\hangx\Desktop\20221204打印\趣谈Linux\" ; # 放到指定文件夹中 
}