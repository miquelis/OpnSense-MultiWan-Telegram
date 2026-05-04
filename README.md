
# OpnSense-MultiWan-Telegram

- Script for OPNsense: monitors multi-WAN gateway status and sends notifications via Telegram (or email with Monit service)

## Screenshot
![Screenshot](https://github.com/macielmeireles/OpnSense-MultiWan-Telegram/blob/main/screenshot.jpg)


## Overview (En)
This project provides two scripts for monitoring the status of gateways in OPNsense and sending alerts to Telegram.

The `gateway_multiwan` script monitors the `offline`, `packet loss`, `online`, or `unknown` status of all gateways found in opnSense. If any of them change, it sends an alert using the `sendTelegram.sh` file to a group, via a Telegram bot. If the SMTP alert is configured, it will also be sent to your email. For it to work, the script needs to be added to your opnSense and set up to be executed and triggered by events through the already included package called Monit.


### Requirements
- OPNsense Firewall
- SSH terminal
- Download the two files from this GitHub repository (stable version) to your machine with OPNsense
- Telegram Account



### Quick Installation Guide
1. Enable SSH on OpnSense
2. Download Files
3. Set Permissions
4. Configure Telegram
5. Edit `sendTelegram.sh`
6. Enable Monit Service
7. Enable Script
8. Test

### Detailed Installation Guide

1. Enable SSH on OpnSense and download the files<br />
   1.1 Enable SSH on OpnSense: System > Settings > Administration <br />
   1.2 Access OpnSense via SSH from terminal: ssh root@192.168.1.1. Replace root with your username and 192.168.1.1 with your OpnSense IP address.<br />
   1.3 Use fetch to download `install_multiwan.sh` from GitHub: <br />
   ```sh
   fetch https://github.com/miquelis/OpnSense-MultiWan-Telegram/blob/6feda9e9675795b128a90a5fad28544901d2bbf8/versions/stable/0.6/install_multiwan.sh
   ```   
   <br />
   1.4 Set +x permission on the files:<br />
   
   ```sh
   chmod +x install_multiwan.sh
   ```
   
   1.5 Run sh:
   ```sh
   sh install_multiwan.sh
   ```

2. Set Permissions:<br />
   2.1 Set +x permission on the files: <br />
      - **gateway_multiwan**
      ```sh
      chmod +x /usr/local/opnsense/scripts/monit/gateway_multiwan
      ```
      <br />
      - **sendTelegram.sh**
      ```sh
      chmod +x /usr/local/opnsense/scripts/monit/sendTelegram.sh
      ```
      <br />

3. Telegram Configuration:<br />
   3.1 Create a Telegram group.<br />
   3.2 Create a bot with "BotFather".<br />
   3.3 Note down the bot token.<br />
   3.4 Add the bot and yourself to the group.<br />
   3.5 Get the group ID from the URL.<br />

4. Configure sendTelegram.sh:<br />
   4.1 Open sendTelegram.sh in a text editor.<br />
   ```sh
   vi /usr/local/opnsense/scripts/monit/sendTelegram.sh
   ```
   4.2 Update TOKEN and CHAT_ID with your bot token and group ID.<br />

5. Enable Monit Service:<br />
   5.1 In OPNsense, go to Services > Monit > Services and click on Enable Monit.<br />
   5.2 Set your preferred polling interval.<br />

6. Enable Script:<br />
   6.1 OPNsense, go to Services > Monit > Services and duplicate the pre-existing service called gateway_alert.<br />
   6.2 In the Duplicate Item dialog box, enter a name for the new service, such as "gateway_multiwan".<br />
   6.3 In the Path field, enter the path to the shell script, such as `/usr/local/opnsense/scripts/monit/gateway_multiwan`.<br />
   6.4 In Tests field, uncheck "NonZeroStatus" and check "ChangedStatus".<br />
   6.5 Click Save and Apply.<br />

### Testing the Script<br />
To test the script, manually disable a WAN link in OPNsense. You should receive a Telegram alert.<br />

For more details on how to get your bot token in Telegram[^1][^2] or how to get your chat ID in Telegram, you can refer to these links.<br />

<sub>(1) How to Generate a Token for Telegram Bot API | https://medium.com/geekculture/generate-telegram-token-for-bot-api-d26faf9bf064</sub> <br />
<sub>(2) How to Find a Chat ID in Telegram | https://www.alphr.com/find-chat-id-telegram/ </sub> <br />
