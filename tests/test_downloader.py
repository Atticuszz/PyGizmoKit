"""
-*- coding: utf-8 -*-
@Organization : SupaVision
@Author       : 18317
@Date Created : 09/02/2024
@Description  :
"""

from pathlib import Path

from pygizmokit import download_files


def test_multidownload() -> None:
    download_urls = [
        # "https://github.com/Atticuszz/BoostFace_fastapi/releases/download/v0.0.1/irn50_glint360k_r50.onnx",
        "https://github.com/Atticuszz/BoostFace_fastapi/archive/refs/tags/v0.0.1.zip",
        "https://github.com/Atticuszz/BoostFace_fastapi/archive/refs/tags/v0.0.1.tar.gz",
        # "https://github.com/Atticuszz/BoostFace/releases/download/v0.0.1/LFW_dataset.zip",
        "https://github.com/Atticuszz/BoostFace/archive/refs/tags/v0.0.1.zip",
        "https://github.com/Atticuszz/BoostFace/archive/refs/tags/v0.0.1.tar.gz",
        "https://github.com/Atticuszz/supabase-py-async/releases/download/v2.5.1/supabase_py_async-2.5.1.tar.gz",
        "https://github.com/Atticuszz/supabase-py-async/archive/refs/tags/v2.5.1.zip",
        "https://github.com/Atticuszz/fastapi_supabase_template/archive/refs/tags/v0.3.1.zip"
    ]

    save_directory = Path().cwd() / "downloads"
    download_files(download_urls)


if __name__ == "__main__":
    test_multidownload()
    # save_directory.rmdir()
