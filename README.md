### Verilog文件在verilog文件夹下

2023.5.17 （copy）verilog完成：（应该是）

- IFetch
- control
- dmemory
- executs
- memOrIO



### 推荐工作流

```bash
# 创建新分支your-dev-part-name
git checkout -b your-dev-part-name origin/main
# 此时会自动切换到新分支，然后你可以在新分支上进行开发

# 开发完成后，将你的分支合并到main主分支
git checkout main
git merge --no-ff your-dev-part-name
111
```

