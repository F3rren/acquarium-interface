# 🧪 Guida Test Sistema Notifiche

## 📱 Come Testare le Notifiche

### 1. **Accesso alla Pagina Test**
1. Apri l'app e naviga in una vasca (tap su card acquario)
2. Premi l'icona 🔔 in alto a destra
3. Vai alla tab **"Test"** (quarta tab)

---

## 🎯 Funzionalità di Test Disponibili

### **A) Test Alert Parametri Singoli**

Nella sezione "Test Alert Parametri" puoi premere i pulsanti per simulare parametri fuori range:

- **🌡️ Temperatura**: Simula 28.5°C (range ottimale: 24-26°C)
- **💧 pH**: Simula pH 7.5 (range ottimale: 8.0-8.4)
- **🌊 Salinità**: Simula 1.030 (range ottimale: 1.023-1.026)
- **🔬 Nitrati**: Simula 25ppm (range ottimale: 0-10ppm)

**Cosa succede:**
- Viene inviata una notifica immediata
- L'alert appare nello "Storico" (tab 3)
- Ricevi uno SnackBar di conferma

---

### **B) Test Promemoria Manutenzione**

Pulsante **"Programma Promemoria"**:
- Programma notifiche ricorrenti per:
  - 🚰 Cambio Acqua (ogni X giorni)
  - 🔧 Pulizia Filtro (ogni X giorni)
  - 📊 Test Parametri (ogni X giorni)
  - 💡 Manutenzione Luci (ogni X giorni)

La frequenza è configurabile nella tab "Impostazioni" usando gli slider.

---

### **C) Monitoraggio Automatico**

Pulsante **"Avvia Monitoraggio"**:
- Simula un sistema di controllo continuo
- Ogni 30 secondi:
  - Randomizza leggermente i parametri
  - Controlla se sono fuori range
  - Invia notifiche automaticamente
- Utile per testare notifiche ripetute

**Per fermare**: Premi "Ferma Monitoraggio"

---

### **D) Reset Parametri**

Pulsante **"Reset Parametri Ottimali"**:
- Riporta tutti i parametri ai valori ottimali
- Utile per resettare dopo i test
- Non invia notifiche

---

## 🔄 Flusso di Test Completo

### Test 1: Alert Singolo
```
1. Vai alla tab "Test"
2. Premi "Temperatura"
3. ✅ Ricevi notifica di alert temperatura alta
4. Vai alla tab "Storico" → vedi alert registrato
5. Premi "Reset Parametri Ottimali"
```

### Test 2: Alert Multipli
```
1. Premi "Temperatura"
2. Premi "pH"
3. Premi "Nitrati"
4. ✅ Ricevi 3 notifiche separate
5. Tab "Storico" → vedi tutti e 3 gli alert con severità diverse
```

### Test 3: Monitoraggio Continuo
```
1. Premi "Avvia Monitoraggio"
2. Aspetta 30-60 secondi
3. ✅ Potresti ricevere notifiche casuali quando parametri escono dal range
4. Tab "Storico" → osserva lo storico che si popola
5. Premi "Ferma Monitoraggio"
```

### Test 4: Promemoria Manutenzione
```
1. Vai alla tab "Impostazioni"
2. Abilita "Promemoria Manutenzione"
3. Configura frequenze con gli slider
4. Premi "Salva Impostazioni"
5. Vai alla tab "Test"
6. Premi "Programma Promemoria"
7. ✅ Le notifiche ricorrenti sono programmate
```

---

## 📊 Verifica Notifiche

### Su Android:
1. Apri "Impostazioni" → "App" → "AcquariumFE"
2. Vai su "Notifiche"
3. Verifica che siano abilitate
4. Controlla i 3 canali:
   - 🔴 **Aquarium Alerts** (Alta priorità)
   - 🔵 **Aquarium Maintenance** (Media priorità)
   - 🟢 **Aquarium Recurring** (Bassa priorità)

### Su iOS:
1. Impostazioni → Notifiche → AcquariumFE
2. Verifica che "Consenti notifiche" sia abilitato
3. Scegli stile notifica (Banner, Alert)

---

## 🎨 Severità Alert

Gli alert sono colorati per severità:

- 🔴 **Critical**: Deviazione >50% dal range
- 🟡 **High**: Deviazione 30-50%
- 🔵 **Medium**: Deviazione 10-30%
- 🟢 **Low**: Deviazione <10%

---

## 🔌 Integrazione con Mockoon

### Setup per Mockoon:
1. **Endpoint Mock**: Crea endpoint REST per parametri
   ```
   GET /api/aquarium/:id/parameters
   ```

2. **Response Mock** (esempio):
   ```json
   {
     "temperature": 28.5,
     "ph": 8.2,
     "salinity": 1.024,
     "orp": 400.0,
     "calcium": 425.0,
     "magnesium": 1300.0,
     "kh": 10.0,
     "nitrate": 5.0,
     "phosphate": 0.05
   }
   ```

3. **Collegamento**: Sostituisci `MockDataService()` con chiamate HTTP
   ```dart
   final response = await http.get(Uri.parse('http://localhost:3000/api/aquarium/1/parameters'));
   final params = jsonDecode(response.body);
   ```

4. **Test Notifiche con Mockoon**:
   - Modifica i valori in Mockoon
   - Simula parametri fuori range
   - L'app riceverà i valori reali e invierà notifiche

---

## ✅ Checklist Test

- [ ] Test alert singolo (Temperatura)
- [ ] Test alert multipli (3+ parametri)
- [ ] Verifica storico alert
- [ ] Test monitoraggio automatico
- [ ] Test promemoria manutenzione
- [ ] Verifica severità (colori diversi)
- [ ] Test reset parametri
- [ ] Verifica permessi notifiche Android/iOS
- [ ] Test notifiche in background (app chiusa)
- [ ] Test tap su notifica (navigazione)

---

## 🐛 Troubleshooting

**Problema**: Non ricevo notifiche
- ✅ Verifica permessi nelle impostazioni del dispositivo
- ✅ Controlla che "Alert Parametri" sia abilitato (tab Impostazioni)
- ✅ Verifica che il parametro sia effettivamente fuori range

**Problema**: Monitoraggio non funziona
- ✅ Controlla che il pulsante sia verde ("Ferma Monitoraggio")
- ✅ Aspetta almeno 30 secondi
- ✅ Le notifiche appaiono solo se parametri escono dal range

**Problema**: Storico vuoto
- ✅ Devi prima triggerare un alert (pulsante test)
- ✅ Lo storico mostra max 100 alert più recenti
- ✅ Riavvia l'app se hai appena installato

---

## 📝 Note di Sviluppo

- **Persistenza**: Attualmente lo storico è in memoria (si perde al riavvio)
- **Background**: Il monitoraggio funziona solo con app aperta
- **Storage**: Per salvare le impostazioni, implementare SharedPreferences
- **WorkManager**: Per monitoraggio background su Android

