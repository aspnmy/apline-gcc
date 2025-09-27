#!/bin/bash
URI="docker.io"
GithubURI="ghcr.io"
Gitte="git.t2be.cn"
AUUSER="aspnmy"
imgNAME="apline-ssh-rc1"
s6OverlayVer="3210"
packageVer="3221"
timeBuild=$(date +"%Y%m%d%H")
#ver="${timeBuild}_s6_overlay_v${s6OverlayVer}_${debianVer}_BestHostsMonitor"
stableVer="${timeBuild}-${imgNAME}-${packageVer}-base"

# 构建镜像
buildah bud --no-cache -f ./Dockerfile-apline-ssh-base -t $URI/$AUUSER/$imgNAME:$stableVer
if [ $? -ne 0 ]; then
    echo "构建镜像失败，退出脚本"
    exit 1
fi

# 打标签
buildah tag $URI/$AUUSER/$imgNAME:$stableVer $GithubURI/$AUUSER/$imgNAME:$stableVer
buildah tag $URI/$AUUSER/$imgNAME:$stableVer $Gitte/$AUUSER/$imgNAME:$stableVer

# 推送镜像逻辑
if buildah push $URI/$AUUSER/$imgNAME:$stableVer; then
    echo "$URI 推送成功"
    if buildah push $GithubURI/$AUUSER/$imgNAME:$stableVer; then
        echo "$GithubURI 推送成功"
    else
        echo "$GithubURI 推送失败"
    fi
elif buildah push $GithubURI/$AUUSER/$imgNAME:$stableVer; then
    echo "$URI 推送失败，但$GithubURI 推送成功"
    if buildah push $Gitte/$AUUSER/$imgNAME:$stableVer; then
        echo "$Gitte 推送成功"
    else
        echo "$Gitte 推送失败"
    fi
else
    echo "所有镜像仓库推送失败"
    exit 1
fi
