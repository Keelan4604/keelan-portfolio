const TOTAL_SECONDS = 8 * 60 + 30;

const timerEl = document.getElementById('timer');
const progressBar = document.getElementById('progressBar');
const startPauseBtn = document.getElementById('startPauseBtn');
const resetBtn = document.getElementById('resetBtn');
const roundDoneBtn = document.getElementById('roundDoneBtn');
const plusRoundBtn = document.getElementById('plusRoundBtn');
const minusRoundBtn = document.getElementById('minusRoundBtn');
const roundCountEl = document.getElementById('roundCount');
const statusText = document.getElementById('statusText');
const historyList = document.getElementById('historyList');
const clearHistoryBtn = document.getElementById('clearHistoryBtn');

let remaining = TOTAL_SECONDS;
let roundCount = 0;
let running = false;
let intervalId = null;

function pad(n) {
  return String(n).padStart(2, '0');
}

function formatTime(seconds) {
  const m = Math.floor(seconds / 60);
  const s = seconds % 60;
  return `${pad(m)}:${pad(s)}`;
}

function updateUI() {
  timerEl.textContent = formatTime(remaining);
  roundCountEl.textContent = roundCount;
  const pct = (remaining / TOTAL_SECONDS) * 100;
  progressBar.style.width = `${Math.max(0, pct)}%`;

  if (remaining <= 10 && running) {
    timerEl.classList.add('flash');
  } else {
    timerEl.classList.remove('flash');
  }

  if (remaining === 0) {
    statusText.textContent = "Time's up — finish that round!";
  } else if (running) {
    statusText.textContent = `Round ${roundCount + 1} in progress...`;
  } else {
    statusText.textContent = `Ready for round ${roundCount + 1}.`;
  }
}

function startTimer() {
  if (running) return;
  running = true;
  startPauseBtn.textContent = 'Pause';

  intervalId = setInterval(() => {
    remaining -= 1;
    if (remaining <= 0) {
      remaining = 0;
      stopTimer();
      ding();
    }
    updateUI();
  }, 1000);
}

function stopTimer() {
  running = false;
  clearInterval(intervalId);
  intervalId = null;
  startPauseBtn.textContent = 'Start';
}

function resetTimer() {
  stopTimer();
  remaining = TOTAL_SECONDS;
  updateUI();
}

function ding() {
  const ctx = new (window.AudioContext || window.webkitAudioContext)();
  const o = ctx.createOscillator();
  const g = ctx.createGain();

  o.type = 'sine';
  o.frequency.setValueAtTime(880, ctx.currentTime);
  g.gain.setValueAtTime(0.0001, ctx.currentTime);
  g.gain.exponentialRampToValueAtTime(0.15, ctx.currentTime + 0.02);
  g.gain.exponentialRampToValueAtTime(0.0001, ctx.currentTime + 0.5);

  o.connect(g);
  g.connect(ctx.destination);
  o.start();
  o.stop(ctx.currentTime + 0.5);
}

function completeRound() {
  roundCount += 1;
  const stamp = new Date().toLocaleTimeString([], { hour: '2-digit', minute: '2-digit', second: '2-digit' });
  const li = document.createElement('li');
  li.textContent = `Round ${roundCount} completed at ${stamp}`;
  historyList.prepend(li);
  resetTimer();
  updateUI();
}

startPauseBtn.addEventListener('click', () => {
  if (running) stopTimer();
  else startTimer();
  updateUI();
});

resetBtn.addEventListener('click', resetTimer);
roundDoneBtn.addEventListener('click', completeRound);
plusRoundBtn.addEventListener('click', () => { roundCount += 1; updateUI(); });
minusRoundBtn.addEventListener('click', () => { roundCount = Math.max(0, roundCount - 1); updateUI(); });
clearHistoryBtn.addEventListener('click', () => { historyList.innerHTML = ''; });

updateUI();
