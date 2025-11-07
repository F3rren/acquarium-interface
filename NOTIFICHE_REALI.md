# 📱 Guida: Notifiche Reali sul Dispositivo

## ✅ Setup Completato

Il sistema è ora configurato per inviare **notifiche reali** che appariranno nella barra notifiche del dispositivo Android/iOS.

---

## 🔧 Configurazione Permessi

### Android ✅
I seguenti permessi sono stati aggiunti in `AndroidManifest.xml`:
- `POST_NOTIFICATIONS` - Inviare notifiche (Android 13+)
- `VIBRATE` - Vibrazioni per notifiche
- `RECEIVE_BOOT_COMPLETED` - Notifiche dopo riavvio
- `SCHEDULE_EXACT_ALARM` - Notifiche programmate precise

### iOS
I permessi vengono richiesti automaticamente all'avvio dell'app tramite il dialog di sistema.

---

## 🧪 Come Testare le Notifiche Reali

### 1. **Avvia l'app sul dispositivo fisico**
```bash
flutter run
```
⚠️ **Importante**: Le notifiche funzionano solo su **dispositivi reali**, non su emulatori.

### 2. **Consenti i permessi**
Al primo avvio:
- **Android**: Dialog automatico per permesso notifiche
- **iOS**: Dialog di sistema "Consenti notifiche"
- Premi **"Consenti"** / **"Allow"**

### 3. **Accedi alla pagina Test**
1. Tap su una card acquario nella homepage
2. Tap sull'icona 🔔 in alto a destra
3. Vai alla tab **"Test"** (quarta tab)

### 4. **Invia Notifica di Test**
Nella sezione **"Test Notifica Reale"** (prima sezione in blu):
1. Premi il pulsante **"Invia Notifica Reale"**
2. ✅ Vedrai un SnackBar: "Notifica inviata!"
3. **Minimizza l'app** o vai alla home del telefono
4. 🎉 Vedrai la notifica nella barra notifiche!

**Contenuto notifica test:**
```
🧪 Test Notifica
Questa è una notifica di test dal sistema AcquariumFE
```

---

## 🎯 Test Notifiche Parametri (Reali)

### Test con Alert Parametri:
1. Nella tab "Test", scorri alla sezione **"Test Alert Parametri"**
2. Premi uno dei pulsanti (es. **"Temperatura"**)
3. L'app invia una notifica REALE con:
   - 🌡️ **Titolo**: "Alert Temperatura"
   - 📝 **Messaggio**: "Valore attuale 28.5°C - Target: 25°C"
   - 🔴 **Icona** e colore in base alla severità
4. **Minimizza l'app** → vedrai la notifica nella barra

**Esempio notifiche reali:**
```
⚠️ Alert Temperatura
Valore attuale 28.5°C - Target: 25°C

💧 Alert pH  
Valore attuale 7.5 - Target: 8.2

🌊 Alert Salinità
Valore attuale 1.030 - Target: 1.024
```

---

## 🔄 Test Monitoraggio Automatico (Notifiche Continue)

1. Nella tab "Test", sezione **"Monitoraggio Automatico"**
2. Premi **"Avvia Monitoraggio"**
3. Ogni 30 secondi:
   - I parametri vengono controllati automaticamente
   - Se un parametro esce dal range → **notifica reale**
4. **Minimizza l'app** o blocca lo schermo
5. Continuerai a ricevere notifiche ogni 30s (se parametri fuori range)

⚠️ **Nota**: Il monitoraggio funziona solo con app aperta (in background o foreground). Per notifiche con app chiusa serve WorkManager (non ancora implementato).

---

## 📅 Test Notifiche Programmate

### Setup:
1. Vai alla tab **"Impostazioni"**
2. Abilita **"Promemoria Manutenzione"**
3. Imposta frequenze con gli slider:
   - Cambio Acqua: es. ogni 7 giorni
   - Pulizia Filtro: es. ogni 14 giorni
4. Premi **"Salva Impostazioni"**

### Programma promemoria:
1. Vai alla tab **"Test"**
2. Sezione **"Test Promemoria Manutenzione"**
3. Premi **"Programma Promemoria"**
4. ✅ Le notifiche vengono programmate

**Quando arriveranno:**
- Alla frequenza impostata (7 giorni, 14 giorni, ecc.)
- Arriveranno **anche con app chiusa** (grazie a flutter_local_notifications)

---

## 🔍 Verifica Permessi Notifiche

### Android:
1. **Impostazioni** del telefono
2. **App** → **AcquariumFE**
3. **Notifiche**
4. Verifica:
   - ✅ Notifiche abilitate
   - ✅ 3 canali visibili:
     - **Aquarium Alerts** (Priorità Alta) 🔴
     - **Aquarium Maintenance** (Priorità Media) 🔵
     - **Aquarium Recurring** (Priorità Bassa) 🟢

### iOS:
1. **Impostazioni** → **Notifiche**
2. Cerca **AcquariumFE**
3. Verifica:
   - ✅ "Consenti notifiche" attivo
   - ✅ Stile: Banner o Alert
   - ✅ Suoni: Attivi

---

## 🎨 Personalizzazione Notifiche

### Caratteristiche notifiche implementate:

**Android:**
- ✅ Icona app
- ✅ Colore blu (#60a5fa)
- ✅ Vibrazione
- ✅ Suono
- ✅ Priorità alta per alert
- ✅ 3 canali separati

**iOS:**
- ✅ Alert visibili
- ✅ Badge sull'icona
- ✅ Suono di sistema
- ✅ Banner nella lock screen

---

## 🐛 Troubleshooting

### ❌ "Non ricevo notifiche"

**1. Controlla permessi:**
```dart
// Verifica permessi in app
import 'package:permission_handler/permission_handler.dart';

final status = await Permission.notification.status;
print('Permesso notifiche: $status');
```

**2. Verifica inizializzazione:**
- I permessi vengono richiesti automaticamente in `main.dart`
- Se non vedi il dialog, reinstalla l'app

**3. Android 13+:**
- Android 13+ richiede permesso esplicito
- Se negato, vai in Impostazioni → App → Permessi

**4. Modalità Non Disturbare:**
- Disabilita "Non Disturbare" sul telefono
- Le notifiche potrebbero essere silenziose

---

### ❌ "Le notifiche non vibrano"

**Android:**
- Verifica volume notifiche (non silenzioso)
- Impostazioni → Suoni → Volume notifiche

**iOS:**
- Verifica interruttore silenzioso laterale
- Impostazioni → Suoni e feedback aptico

---

### ❌ "Funziona solo su emulatore"

⚠️ **Le notifiche NON funzionano su emulatori Android/iOS**

Devi usare un dispositivo fisico:
```bash
# Collega telefono via USB
# Abilita Debug USB (Android) o Developer Mode (iOS)
flutter run
```

---

## 📊 Statistiche Notifiche

### Comandi utili:

**Visualizza notifiche programmate:**
```dart
final pending = await NotificationService().getPendingNotifications();
print('Notifiche programmate: ${pending.length}');
for (var n in pending) {
  print('ID: ${n.id}, Title: ${n.title}');
}
```

**Cancella tutte le notifiche:**
```dart
await NotificationService().cancelAllNotifications();
```

**Cancella notifica specifica:**
```dart
await NotificationService().cancelNotification(999); // ID test notification
```

---

## 🚀 Prossimi Step (Opzionali)

### 1. **Notifiche con app chiusa (Background)**
```yaml
# Aggiungi a pubspec.yaml
dependencies:
  workmanager: ^0.5.2
```
Implementa WorkManager per controllare parametri periodicamente.

### 2. **Deep Linking**
Quando tap su notifica → apri pagina specifica:
```dart
void _onNotificationTapped(NotificationResponse response) {
  if (response.payload == 'temperature') {
    Navigator.pushNamed(context, '/parameters');
  }
}
```

### 3. **Notifiche Push (Firebase)**
Per notifiche da server remoto (es. da Mockoon):
```yaml
dependencies:
  firebase_messaging: ^14.7.0
```

---

## ✅ Checklist Test Completo

- [ ] Richiesta permessi all'avvio
- [ ] Test notifica reale (pulsante blu)
- [ ] Notifica appare nella barra
- [ ] Test alert temperatura
- [ ] Test monitoraggio automatico (30s)
- [ ] Minimizza app → ricevi notifiche
- [ ] Verifica suono e vibrazione
- [ ] Tap su notifica → apre app
- [ ] Test promemoria programmati
- [ ] Verifica 3 canali in impostazioni Android

---

## 🎉 Risultato Finale

Dopo questi test, avrai:
- ✅ Notifiche reali sul dispositivo
- ✅ Alert parametri fuori range
- ✅ Promemoria manutenzione programmati
- ✅ Monitoraggio automatico (con app aperta)
- ✅ Storico completo degli alert
- ✅ Sistema pronto per integrazione con Mockoon

**Ora puoi testare le notifiche come in un'app in produzione!** 🚀
