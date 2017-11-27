Google AIY on Resin OS
===

This sets up the Google AIY project on a [ResinOS unmanaged Pi](https://resinos.io/).

## Credentials

You need to [follow the instructions](https://aiyprojects.withgoogle.com/voice#users-guide-1-1--connect-to-google-cloud-platform) to get a `client_secrets_XXXX.json` file. The instructions say "Using your voice recognizer device" but you can do this on whatever device you're going use resin on.

Rename the `client_secrets_XXXX.json` file you download to `assistant.json` and place it in the directory containing the `Dockerfile`.

## Installation

Provision a Pi using the ResinOS [getting started instructions](https://resinos.io/docs/raspberrypi3/gettingstarted/) for your type of Pi.

The process can't be run completely automatically so you have to:
- send the project to the Pi to be built using `resin local push --source .`
- ssh into the Pi `resin local ssh`
- run `/usr/app/start.sh`
- follow the web link to link to your Google Acount
- paste in the credential code that the web gives you into the terminal

The credentials are saved to `/data` so the authorisation should persist between container rebuilds.

You can then comment out the `CMD ["bash"]` line of the `Dockerfile` and incomment the `CMD ["bash", "start.sh"]` line which will start the assistant automatically on start-up.

## Better sound with a phatDAC

If you also want to use a phat dac sound card for sound output:

- ssh into the host `sudo resin local ssh --host`
- Edit the `config.txt` using `vi`: `vi /mnt/boot/config.txt`
- Press (capital) 'G' to jump to the bottom of the file
- Press (lowercase) 'i' to begin editing
- Comment out `#dtparam=audio=on`
- Add the line `dtoverlay=hifiberry-dac` on the last line
- Press ':x' to save the file
- `sync`
- `reboot`

It should then work.

