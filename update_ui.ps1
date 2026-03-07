$files = Get-ChildItem 'D:\Nam 1 +2\Luat\bankruptcy-slide-*.html'

foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw -Encoding UTF8
    
    $cssToAdd = @"
    .hidden-panel {
      position: absolute; left: -200px; top: 50%; transform: translateY(-50%);
      width: 180px; padding: 20px; background: rgba(10, 25, 47, 0.6);
      border: 1px solid rgba(88, 166, 255, 0.2); border-left: 3px solid var(--color-accent);
      backdrop-filter: blur(15px); -webkit-backdrop-filter: blur(15px);
      color: var(--color-text-muted);
      font-size: 11px; font-family: monospace; letter-spacing: 0.1em; line-height: 1.8;
      transition: all 0.6s cubic-bezier(0.16, 1, 0.3, 1); opacity: 0; z-index: 25;
      box-shadow: 10px 20px 40px rgba(0,0,0,0.5);
    }
    .viewport:hover .hidden-panel { left: 40px; opacity: 1; }
    
    .status-indicator { color: #10b981; text-shadow: 0 0 8px rgba(16, 185, 129, 0.6); }
    
    .tech-deco {
      position: absolute; right: -200px; top: 50%; transform: translateY(-50%);
      width: 180px; padding: 20px; background: rgba(10, 25, 47, 0.6);
      border: 1px solid rgba(88, 166, 255, 0.2); border-right: 3px solid var(--color-accent);
      backdrop-filter: blur(15px); -webkit-backdrop-filter: blur(15px);
      color: var(--color-text-muted); text-align: right;
      font-size: 11px; font-family: monospace; letter-spacing: 0.1em; line-height: 1.8;
      transition: all 0.6s cubic-bezier(0.16, 1, 0.3, 1); opacity: 0; z-index: 25;
      box-shadow: -10px 20px 40px rgba(0,0,0,0.5);
    }
    .viewport:hover .tech-deco { right: 40px; opacity: 1; }
"@

    if ($content -notmatch "\.hidden-panel") {
        $content = $content -replace "</style>", "$cssToAdd`n  </style>"
    }
    
    $htmlToAdd = @"
    <div class="hud-brackets"></div>
    <div class="ui-meta">
      <span>SYS.OP.2025</span>
      <span class="status-indicator">STATUS: ACTIVE</span>
    </div>
    <div class="hidden-panel">
      <div style="margin-bottom: 10px; color: var(--color-accent); font-weight: bold;">[ SYSTEM DATA ]</div>
      <div>ENCRYPT: 256-BIT</div>
      <div>NODE: PRIME-VN</div>
      <div>LATENCY: 12ms</div>
      <div style="margin-top: 10px; height: 1px; background: rgba(255,255,255,0.1);"></div>
      <div style="margin-top: 10px; font-size: 9px; opacity: 0.5;">AWAITING INPUT...</div>
    </div>
    <div class="tech-deco">
      <div style="margin-bottom: 10px; color: var(--color-accent); font-weight: bold;">[ MODULE INFO ]</div>
      <div>VER: 4.0.1b</div>
      <div>SYNC: REALTIME</div>
      <div>MEM: OPTIMAL</div>
      <div style="margin-top: 10px; height: 1px; background: rgba(255,255,255,0.1);"></div>
      <div style="margin-top: 10px; font-size: 9px; opacity: 0.5;">CONNECTION SECURE</div>
    </div>
"@

    if ($content -notmatch "hud-brackets") {
        $content = $content -replace '<canvas id="particles-canvas"></canvas>', "<canvas id=`"particles-canvas`"></canvas>`n$htmlToAdd"
    }

    Set-Content $file.FullName -Value $content -Encoding UTF8
}
