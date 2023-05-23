2023.5.17 （copy）verilog完成：

- IFetch
- control
- dmemory
- executs
- memOrIO

2023.5.23 完成

- 所有基本CPU模块
- Uart通信模块
- 测试场景1的前7项
- 测试场景2的后4项

### 推荐工作流

```bash
# 创建新分支your-dev-part-name
git checkout -b your-dev-part-name origin/main
# 此时会自动切换到新分支，然后你可以在新分支上进行开发

# 开发完成后，将你的分支合并到main主分支
git checkout main
git merge --no-ff your-dev-part-name
```

