#!/usr/bin/env python3

"""
ARCHIVE v3.0 - The 'DaeMarchy' Media Downloader
Replaces the old Bash script with a robust Python engine.
"""

import sys
import os
import argparse
from pathlib import Path
import yt_dlp
from rich.console import Console
from rich.panel import Panel
from rich.progress import Progress, SpinnerColumn, TextColumn
import questionary

# --- CONFIGURATION ---
# Detect directories or fallback to safe defaults
HOME = Path.home()
DIR_VIDEO = Path(os.getenv("XDG_VIDEOS_DIR", HOME / "Videos"))
DIR_MUSIC = Path(os.getenv("XDG_MUSIC_DIR", HOME / "Music"))
HIST_VIDEO = HOME / ".config/archive_history_video.txt"
HIST_MUSIC = HOME / ".config/archive_history_music.txt"

# Ensure config exists
HIST_VIDEO.parent.mkdir(parents=True, exist_ok=True)
DIR_VIDEO.mkdir(parents=True, exist_ok=True)
DIR_MUSIC.mkdir(parents=True, exist_ok=True)

console = Console()

# --- ENGINE ---

def get_ydl_opts(mode, url):
    """Returns the dictionary of options for yt-dlp based on mode."""
    
    # Base options for all modes
    opts = {
        'quiet': True,
        'no_warnings': True,
        'addmetadata': True,
        'writethumbnail': True,
        'embedsub': True,
        'subtitleslangs': ['all', '-live_chat'],
        'updatetime': False, # --no-mtime
        # Use aria2c if available (optional speed boost)
        'external_downloader': 'aria2c' if os.system("which aria2c > /dev/null") == 0 else None,
        'external_downloader_args': ['-x', '4', '-k', '1M'] if os.system("which aria2c > /dev/null") == 0 else None,
    }

    if mode == "audio":
        opts.update({
            'format': 'bestaudio/best',
            'download_archive': str(HIST_MUSIC),
            'outtmpl': str(DIR_MUSIC / '%(title)s.%(ext)s'),
            'postprocessors': [{
                'key': 'FFmpegExtractAudio',
                'preferredcodec': 'mp3',
                'preferredquality': '192',
            }],
        })
    
    elif mode == "video":
        # Default Best Video
        opts.update({
            'format': 'bv+ba/b',
            'merge_output_format': 'mkv',
            'download_archive': str(HIST_VIDEO),
            'outtmpl': str(DIR_VIDEO / '%(title)s [%(id)s].%(ext)s'),
        })
        
    return opts

def fetch_metadata(url):
    """Fetches video info without downloading."""
    with yt_dlp.YoutubeDL({'quiet': True}) as ydl:
        try:
            return ydl.extract_info(url, download=False)
        except Exception as e:
            console.print(f"[bold red]❌ Error:[/bold red] {e}")
            sys.exit(1)

def interactive_select(url):
    """The Scan & Select Menu."""
    console.print(f"[cyan]🔍 Scanning metadata for:[/cyan] {url}")
    
    with console.status("[bold green]Fetching formats...[/bold green]"):
        info = fetch_metadata(url)

    formats = info.get('formats', [])
    choices = []
    
    # Filter and format the list
    for f in formats:
        f_id = f.get('format_id', 'N/A')
        ext = f.get('ext', 'N/A')
        res = f.get('resolution') or "audio only"
        note = f.get('format_note', '')
        filesize = f.get('filesize') or f.get('filesize_approx')
        
        # Pretty size
        size_str = f"{filesize / 1024 / 1024:.1f}MB" if filesize else "N/A"
        
        # Color code the rows
        display_text = f"{f_id:<5} | {ext:<4} | {res:<12} | {size_str:<8} | {note}"
        
        choices.append(questionary.Choice(
            title=display_text,
            value=f_id
        ))

    # Reverse to put high quality at bottom (standard convention)
    choices.reverse()
    
    # Show the menu
    selected_id = questionary.select(
        "Select Format:",
        choices=choices,
        style=questionary.Style([('answer', 'fg:cyan bold')])
    ).ask()
    
    if not selected_id:
        console.print("[yellow]Cancelled.[/yellow]")
        sys.exit(0)
        
    return selected_id

def run_download(url, mode="video", format_id=None):
    """Executes the download."""
    opts = get_ydl_opts(mode, url)
    
    if format_id:
        # Override format if manually selected
        # If it's audio-only ID, don't try to merge video
        if "audio" in mode:
             opts['format'] = format_id
        else:
             # Merge selected video ID + best audio
             opts['format'] = f"{format_id}+bestaudio/best"

    # Define a progress hook to show rich output
    def progress_hook(d):
        if d['status'] == 'downloading':
            p = d.get('_percent_str', '0%')
            s = d.get('_speed_str', 'N/A')
            e = d.get('_eta_str', 'N/A')
            sys.stdout.write(f"\rDownloading: {p} @ {s} (ETA: {e})")
            sys.stdout.flush()
        elif d['status'] == 'finished':
            sys.stdout.write("\n")
            console.print("[bold green]✨ Download Complete![/bold green]")

    opts['progress_hooks'] = [progress_hook]

    try:
        with yt_dlp.YoutubeDL(opts) as ydl:
            ydl.download([url])
    except Exception as e:
        console.print(f"[red]Download failed:[/red] {e}")

# --- MAIN ---

def main():
    parser = argparse.ArgumentParser(description="The DaeMarchy Media Downloader")
    parser.add_argument("url", nargs="?", help="URL to download")
    parser.add_argument("-a", "--audio", action="store_true", help="Download as MP3 (Audio Mode)")
    parser.add_argument("-b", "--best", action="store_true", help="Download best quality (Skip Menu)")
    
    args = parser.parse_args()
    
    # Handle Clipboard if no URL
    if not args.url:
        import shutil
        if shutil.which("wl-paste"):
            clip = os.popen("wl-paste").read().strip()
        elif shutil.which("pbpaste"):
             clip = os.popen("pbpaste").read().strip()
        else:
            clip = ""
            
        if clip.startswith("http"):
            console.print(f"[yellow]📋 Found URL in clipboard:[/yellow] {clip}")
            args.url = clip
        else:
            parser.print_help()
            sys.exit(1)

    # Dispatcher
    if args.audio:
        console.print(Panel(f"🎵 [bold blue]Audio Mode[/bold blue]\nTarget: {DIR_MUSIC}", border_style="blue"))
        run_download(args.url, mode="audio")
        
    elif args.best:
        console.print(Panel(f"🚀 [bold green]Best Quality Mode[/bold green]\nTarget: {DIR_VIDEO}", border_style="green"))
        run_download(args.url, mode="video")
        
    else:
        # Interactive Mode
        f_id = interactive_select(args.url)
        console.print(Panel(f"🎬 [bold cyan]Custom Quality Mode[/bold cyan]\nTarget: {DIR_VIDEO}", border_style="cyan"))
        
        # Check if user selected an audio-only format code
        # (Naive check: usually 140, 251, etc. but let yt-dlp handle the merge logic)
        run_download(args.url, mode="video", format_id=f_id)

if __name__ == "__main__":
    main()
