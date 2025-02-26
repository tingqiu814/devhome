document.addEventListener('DOMContentLoaded', () => {
  const inputArea = document.getElementById('inputArea');
  const downloadBtn = document.getElementById('downloadBtn');
  const clearBtn = document.getElementById('clearBtn');
  const progressFill = document.querySelector('.progress-fill');
  const statusMessages = document.getElementById('statusMessages');
  const helpBtn = document.getElementById('helpBtn');

  // 并发控制
  const MAX_CONCURRENT = 3;
  let activeDownloads = 0;
  let queue = [];
  let totalTasks = 0;
  let completedTasks = 0;

  // 下载处理器
  const processDownload = async (line) => {
    const [rawPath, rawUrl] = line.split('||').map(s => s.trim());
    if (!rawPath || !rawUrl) return;

    try {
      const url = new URL(rawUrl);
      const fileName = extractFileName(url);
      const safePath = sanitizePath(rawPath);
      const fullPath = `${safePath}/${fileName}`;

      await chrome.downloads.download({
        url: rawUrl,
        filename: fullPath,
        conflictAction: 'uniquify'
      });

      updateStatus(`✓ 下载成功: ${fullPath}`, 'success');
    } catch (error) {
      updateStatus(`✗ 失败: ${error.message}`, 'error');
    } finally {
      completedTasks++;
      activeDownloads--;
      updateProgress();
      processQueue();
    }
  };

  // 文件名提取
  const extractFileName = (url) => {
    const params = url.searchParams;
    const encodedName = params.get('n') || url.pathname.split('/').pop();
    return decodeURIComponent(encodedName).replace(/[\\/:"*?<>|]/g, '');
  };

  // 路径消毒
  const sanitizePath = (path) => {
    return path
      .replace(/\.\.\//g, '')
      .replace(/\/+/g, '/')
      .replace(/^\/|\/$/g, '')
      .replace(/[\\:*?"<>|]/g, '');
  };

  // 状态更新
  const updateStatus = (message, type = 'info') => {
    const div = document.createElement('div');
    div.className = `status-message ${type}`;
    div.textContent = `[${new Date().toLocaleTimeString()}] ${message}`;
    statusMessages.appendChild(div);
    statusMessages.scrollTop = statusMessages.scrollHeight;
  };

  // 进度更新
  const updateProgress = () => {
    const progress = totalTasks > 0 ? (completedTasks / totalTasks) * 100 : 0;
    progressFill.style.width = `${progress}%`;
  };

  // 队列处理器
  const processQueue = () => {
    while (activeDownloads < MAX_CONCURRENT && queue.length > 0) {
      activeDownloads++;
      const task = queue.shift();
      task();
    }
  };

  // 下载按钮点击
  downloadBtn.addEventListener('click', () => {
    const lines = inputArea.value.trim().split('\n');
    if (lines.length === 0) return;

    totalTasks = lines.length;
    completedTasks = 0;
    activeDownloads = 0;
    queue = lines.map(line => () => processDownload(line));
    
    statusMessages.innerHTML = '';
    updateProgress();
    processQueue();
  });

  // 清空按钮
  clearBtn.addEventListener('click', () => {
    inputArea.value = '';
    statusMessages.innerHTML = '';
    progressFill.style.width = '0%';
  });

  // 帮助按钮
  helpBtn.addEventListener('click', () => {
    alert([
      "使用说明：",
      "1. 每行格式：目录路径 || 下载地址",
      "2. 示例：",
      "   全部文件/文档 || http://example.com/file.doc?n=文件名.doc",
      "3. 支持自动创建多级目录",
      "4. 文件名优先从URL参数n获取"
    ].join('\n'));
  });
});
