#Should be run on a Windows computer with outlook installed (and must also be logged into outlook account)

import win32com.client

outlook = win32com.client.Dispatch("Outlook.Application").GetNamespace("MAPI")

tannoy = "" #enter tannoy's email address here
inbox = outlook.GetDefaultFolder(6)

messages = inbox.Items

for message in messages:
  try:
    if message.Sender.Address == tannoy:
      print(message.Body)
      break
  except:
    pass

