/* REQUISITI */

- Questo progetto deve essere eseguito su una macchina virtuale.

- Tutti i file necessari per la configurazione del tuo progetto devono essere posizionati in una cartella srcs.

- È inoltre richiesto un Makefile che deve essere posizionato nella root della directory. 
  - Deve configurare l'intera applicazione (ovvero deve creare le immagini Docker utilizzando docker-compose.yml).

- Ogni immagine Docker deve avere lo stesso nome del servizio corrispondente.

- Ogni servizio deve essere eseguito in un container dedicato.

- Per motivi di prestazioni, i containers devono essere costruiti dalla penultima versione stabile di Alpine Linux o da Debian Buster.

- Scrivere i tuoi Dockerfile, uno per servizio.
  - I Dockerfile devono essere chiamati nel docker-compose.yml dal Makefile.

- Non deve essere presente alcuna password nei Dockerfile.
  - Ciò significa che bisogna creare le immagini Docker del progetto. È quindi vietato scaricare immagini Docker già pronte, 
    nonché utilizzare servizi come DockerHub (Alpine/Debian esclusi).

- L'utilizzo di network: host o --link o links: è vietato.

- I containers non devono essere avviati con un comando che esegue un ciclo infinito. 
  - Quindi stessa cosa per qualsiasi comando utilizzato come entrypoint o utilizzato negli script entrypoint.
    --> Entrypoint: è un comando specificato nell'immagine Docker che viene eseguito quando un container viene avviato. 
                    è l'ultimo comando specificato nell'istruzione Dockerfile e viene eseguito dopo l'istruzione CMD.
    
- Vietato: tail -f, bash, sleep infinity, while true. <--

- Il container NGINX deve essere l'unico punto di ingresso nella tua infrastruttura tramite la porta 443, 
  utilizzando solo il protocollo TLSv1.2 o TLSv1.3.



/* TODO LIST */

1) Un container Docker che contiene NGINX con solo TLSv1.2 o TLSv1.3.

2) Un container Docker che contiene WordPress + php-fpm (deve essere installato e configurato) solo senza nginx.

3) Un container Docker che contiene solo MariaDB senza nginx.

4) Un volume che contiene il database di WordPress.
    --> Volume: è una funzionalità che consente ai container di accedere e memorizzare dati al di fuori del sistema dei file del container stesso. Sono utili quando si vuole condividere i dati tra i container o persistere i dati generati da un container anche dopo la sua eliminazione.

5) Un secondo volume che contiene i file del sito web di WordPress.

6) Una docker-network che stabilisce la connessione tra i containers.

7) I containers devono riavviarsi in caso di crash.

8) Nel tuo database WordPress, devono esserci due utenti, uno dei quali è l'admin. 
   - Il nome utente dell'admin non può contenere admin/Admin o administrator/Administrator (ad esempio, admin, administrator, Administrator, admin-123, ecc.).

9) I volumi saranno disponibili nella cartella /home/login/data della macchina host usando Docker. Naturalmente, devi sostituire login con il tuo.

10) Per semplificare le cose, configurare il nome di dominio in modo che punti all'indirizzo IP locale. 
    Questo nome di dominio deve essere login.42.fr. Di nuovo, devi usare il tuo login. 
    Ad esempio, se il tuo login è wil, wil.42.fr reindirizzerà all'indirizzo IP che punta al sito web di wil.

11) È obbligatorio utilizzare le variabili d'ambiente. Inoltre, è fortemente consigliato utilizzare un file .env per archiviare le variabili d'ambiente.