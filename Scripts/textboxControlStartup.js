  var container = document.getElementById('controlAddIn');

    container.innerHTML = `
       <div class="barcode-container">
            <label class="barcode-label">Finish Order</label>
            <input type="text" id="barcodeInput" class="barcode-input" autofocus placeholder="Scan Barcode..." />
        </div>
    `;