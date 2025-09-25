# Alpine-GCC 最小基础镜像

主要用于在Alpine Linux中使用GCC构建程序的最小基础镜像。

## 特性
- 基于Alpine Linux 3.22.1
- 包含GCC编译器
- 包含Bash及相关工具
- 使用清华大学镜像源加速下载

## GitHub 自动构建

该项目已配置GitHub Actions自动构建，每当：
- 推送到main分支
- 创建版本标签（格式：v*.*.*）
- 手动触发工作流

镜像会自动构建并推送到GitHub Container Registry。

## 使用方法

### 拉取镜像
```bash
docker pull ghcr.io/${{ github.repository }}:latest
```

### 作为基础镜像使用
```dockerfile
FROM ghcr.io/${{ github.repository }}:latest

# 添加你的构建指令
```

### 直接运行
```bash
docker run -it --rm ghcr.io/${{ github.repository }}:latest /bin/bash
```

## 镜像内容
- Alpine Linux 3.22.1
- GCC
- Bash, Bash-doc, Bash-completion
