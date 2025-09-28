package io.jiangbyte.app.modular.sys.file.service;

import io.jiangbyte.framework.file.FileInfo;
import org.springframework.core.io.Resource;
import org.springframework.web.multipart.MultipartFile;

import java.io.FileNotFoundException;
import java.io.IOException;

public interface FileStorageService {
    FileInfo store(MultipartFile file) throws IOException;

    Resource loadAsResource(String filename) throws FileNotFoundException;

    boolean isPreviewable(String filename);

    void delete(String filename) throws IOException;

    String getFileUrl(String filename);
}