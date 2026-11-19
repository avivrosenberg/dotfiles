// Shared script of a report page. Copy it to <reports>/assets/report.js.
// 1. Tabs: each .tabs block holds .tab-panel children with a data-tab label. This script adds one
//    button per panel and shows the first panel.
// 2. Image zoom: a click on a figure image opens it in a Viewer.js overlay (library, not custom
//    code). Wheel or toolbar to zoom, drag to pan, click outside the image or Esc to close.

document.querySelectorAll(".tabs").forEach((tabs) => {
  const panels = Array.from(tabs.querySelectorAll(":scope > .tab-panel"));
  const bar = document.createElement("div");
  bar.className = "tab-buttons";
  bar.setAttribute("role", "tablist");
  panels.forEach((panel, index) => {
    const button = document.createElement("button");
    button.type = "button";
    button.textContent = panel.dataset.tab;
    button.setAttribute("role", "tab");
    button.addEventListener("click", () => {
      panels.forEach((other, j) => { other.hidden = j !== index; });
      bar.querySelectorAll("button").forEach((b, j) => b.setAttribute("aria-selected", String(j === index)));
    });
    bar.appendChild(button);
    panel.hidden = index !== 0;
  });
  bar.querySelector("button").setAttribute("aria-selected", "true");
  tabs.prepend(bar);
});

(function enableImageZoom() {
  const BASE = "https://cdnjs.cloudflare.com/ajax/libs/viewerjs/1.11.6/";
  const link = document.createElement("link");
  link.rel = "stylesheet";
  link.href = BASE + "viewer.min.css";
  document.head.appendChild(link);
  const script = document.createElement("script");
  script.src = BASE + "viewer.min.js";
  script.onload = () => {
    document.querySelectorAll("figure img").forEach((img) => {
      new Viewer(img, {
        navbar: false, title: false, tooltip: false, keyboard: true, backdrop: true,
        minZoomRatio: 0.1, maxZoomRatio: 20,
        toolbar: { zoomIn: 1, zoomOut: 1, oneToOne: 1, reset: 1 },
      });
    });
  };
  document.head.appendChild(script);
})();
