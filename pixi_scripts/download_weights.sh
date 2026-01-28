#!/bin/bash
set -e

# Define cache directory matching the python code expectations or standard torch cache
CACHE_DIR="$HOME/.cache/torch/hub/checkpoints"
mkdir -p "$CACHE_DIR"

echo "Downloading weights to $CACHE_DIR..."

# MegaLoc
if [ ! -f "$CACHE_DIR/megaloc.torch" ]; then
    wget -q -O "$CACHE_DIR/megaloc.torch" \
      "https://github.com/gmberton/MegaLoc/releases/download/v1.0/megaloc.torch" && echo "✅ MegaLoc Downloaded"
else
    echo "✅ MegaLoc already exists"
fi

# ALIKED
if [ ! -f "$CACHE_DIR/aliked-n16.pth" ]; then
    wget -q -O "$CACHE_DIR/aliked-n16.pth" \
      "https://github.com/Shiaoming/ALIKED/raw/main/models/aliked-n16.pth" && echo "✅ ALIKED Downloaded"
else
    echo "✅ ALIKED already exists"
fi

# LightGlue
if [ ! -f "$CACHE_DIR/aliked_lightglue_v0-1_arxiv.pth" ]; then
    wget -q -O "$CACHE_DIR/aliked_lightglue_v0-1_arxiv.pth" \
      "https://github.com/cvg/LightGlue/releases/download/v0.1_arxiv/aliked_lightglue.pth" && echo "✅ LightGlue Weights Downloaded"
else
    echo "✅ LightGlue Weights already exist"
fi

# SuperGluePretrainedNetwork (cloned repo)
mkdir -p scripts/external
if [ ! -d "scripts/external/SuperGluePretrainedNetwork" ]; then
    echo "Cloning SuperGluePretrainedNetwork..."
    git clone https://github.com/magicleap/SuperGluePretrainedNetwork.git scripts/external/SuperGluePretrainedNetwork
else
    echo "✅ SuperGluePretrainedNetwork already exists"
fi

# DPVO (Third Party)
mkdir -p third_party
if [ ! -d "third_party/DPVO" ]; then
    echo "Cloning DPVO..."
    git clone https://github.com/princeton-vl/DPVO.git third_party/DPVO
    # Install in editable mode
    echo "Installing DPVO..."
    cd third_party/DPVO
    pip install -e .
    cd ../..
else
    echo "✅ DPVO already exists"
fi

# DPVO Weights
if [ ! -f "third_party/DPVO/dpvo.pth" ]; then
    echo "Downloading DPVO Weights..."
    wget -q -O "third_party/DPVO/dpvo.pth" \
      "https://github.com/princeton-vl/DPVO/releases/download/v1.0/dpvo.pth" && echo "✅ DPVO Weights Downloaded"
else
    echo "✅ DPVO Weights already exist"
    echo "✅ DPVO Weights already exist"
fi

# Depth-Anything-3 Weights
DA3_WEIGHTS_DIR="submodules/Depth-Anything-3/da3_streaming/weights"
mkdir -p "$DA3_WEIGHTS_DIR"

echo "Checking Depth-Anything-3 weights in $DA3_WEIGHTS_DIR..."

# SALAD
if [ ! -f "$DA3_WEIGHTS_DIR/dino_salad.ckpt" ]; then
    echo "Downloading SALAD weights..."
    wget -q -O "$DA3_WEIGHTS_DIR/dino_salad.ckpt" \
      "https://github.com/serizba/salad/releases/download/v1.0.0/dino_salad.ckpt" && echo "✅ SALAD Downloaded"
else
    echo "✅ SALAD already exists"
fi

# DA3NESTED-GIANT-LARGE-1.1
if [ ! -f "$DA3_WEIGHTS_DIR/config.json" ]; then
    echo "Downloading DA3 Config..."
    wget -q -O "$DA3_WEIGHTS_DIR/config.json" \
      "https://huggingface.co/depth-anything/DA3NESTED-GIANT-LARGE-1.1/resolve/main/config.json" && echo "✅ DA3 Config Downloaded"
fi

if [ ! -f "$DA3_WEIGHTS_DIR/model.safetensors" ]; then
    echo "Downloading DA3 Model (~6.8 GB)..."
    wget -q -O "$DA3_WEIGHTS_DIR/model.safetensors" \
      "https://huggingface.co/depth-anything/DA3NESTED-GIANT-LARGE-1.1/resolve/main/model.safetensors" && echo "✅ DA3 Model Downloaded"
else
    echo "✅ DA3 Model already exists"
fi
