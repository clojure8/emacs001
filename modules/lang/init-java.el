;;; init-java.el --- The necessary settings -*- lexical-binding: t -*-

(defun find-project-root ()
  "Find the root of the project. First, check for the `src/main/java` directory by walking up from the current buffer's directory. If not found, fallback to checking for `pom.xml`, `build.gradle`, or other configuration files. If all checks fail, use the current buffer's directory."
  (let ((dir (file-name-directory (or (buffer-file-name) default-directory))))
    ;; 逐级向上查找src/main/java目录
    (catch 'found
      (while dir
        (let ((parent-dir (file-name-directory (directory-file-name dir))))
          (if (file-exists-p (expand-file-name "src/main/java" dir))
              (throw 'found dir)
            ;; 如果到了根目录, 停止循环
            (if (or (string= dir parent-dir)
                    (not parent-dir))
                (setq dir nil)
              (setq dir parent-dir))))))
    ;; 如果没找到src/main/java目录，继续向上查找pom.xml或build.gradle
    (let ((current-dir (file-name-directory (or (buffer-file-name) default-directory))))
      (catch 'found-config
        (while current-dir
          (if (or (file-exists-p (expand-file-name "pom.xml" current-dir))
                  (file-exists-p (expand-file-name "build.gradle" current-dir)))
              (throw 'found-config current-dir)
            (let ((parent-dir (file-name-directory (directory-file-name current-dir))))
              (if (or (string= current-dir parent-dir)
                      (not parent-dir))
                  (setq current-dir nil)
                (setq current-dir parent-dir)))))))
    ;; 返回找到的项目根目录，或当前缓冲区的目录
    (or (when (fboundp 'projectile-project-root)  ;; 使用 projectile
          (projectile-project-root))
        (vc-root-dir)  ;; 使用版本控制根目录
        (if (file-exists-p (or (buffer-file-name) default-directory))
            (file-name-directory (or (buffer-file-name) default-directory))
          (user-error "Cannot find project root!")))))

(defun new-java-file (type package-name)
  "Create a new Java file of TYPE (class or interface) based on PACKAGE-NAME, and insert the corresponding snippet."
  (interactive
   (list
    (completing-read "Type (class/interface): " '("class" "interface"))
    (read-string "Package and class name (e.g., com.sum.Hello): ")))
  (let* ((project-root (find-project-root))  ;; 获取项目根目录
         (base-dir (expand-file-name "src/main/java/" project-root))  ;; 基于项目根目录的Java代码目录
         (package-parts (split-string package-name "\\."))  ;; 将 package 名字分割成部分
         (file-name (concat (car (last package-parts)) ".java"))  ;; 获取类名
         (package-dir (mapconcat 'identity (butlast package-parts) "/"))  ;; 将包名转为目录结构
         (full-dir (concat base-dir package-dir))  ;; 完整的目录路径
         (full-path (expand-file-name file-name full-dir))  ;; 完整的文件路径
         (snippet (cond
                   ((string= type "class") (yas-lookup-snippet "cls" 'java-mode))
                   ((string= type "interface") (yas-lookup-snippet "interface" 'java-mode)))))
    ;; 如果目录不存在，创建目录
    (unless (file-exists-p full-dir)
      (make-directory full-dir t))
    ;; 打开文件
    (find-file full-path)
    ;; 插入 package 声明
    (insert (format "package %s;\n\n" (mapconcat 'identity (butlast package-parts) ".")))
    ;; 插入相应的 yasnippet 片段
    (when snippet
      (yas-expand-snippet snippet))))

(provide 'init-java)
