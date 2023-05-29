 $rawPath = "D:\CaseLog\DiagnosticsLogs"; # 日志文件夹路径
 $allFile = Get-ChildItem $rawPath -Include *.log -recurse; #获取子文件夹内所有log文件
 foreach ($file in $allFile)
{
    #Write-Host $file.Name;
    Get-Content $file >> $rawPath\all.txt; #将日志文件合并到一个txt文件中
}