document.addEventListener("DOMContentLoaded", () => {
    // --- Global Variables ---
    const container = document.getElementById('controlAddIn');
    const inputId = 'barcodeInput';

    // Initialize
    initializeEventListeners();

    // --- Helper Functions ---
    function invokeOnFocusOut(barcode) {
        Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('OnFocusOut', [barcode]);
    }

    // --- Event Handlers ---

    function onFocusOutHandler(event) {
        if (event.target && event.target.id === inputId) {
            const barcode = event.target.value?.trim();
            if (barcode) {
                invokeOnFocusOut(barcode);
                refocusInput(6);
            }
        }
    }

    function onKeyDownHandler(event) {
        if (event.target.id === inputId && event.key === 'Enter') {
            event.preventDefault();  // Prevent form submit or default behavior
            event.target.blur();     // Trigger focusout event
        }
    }

    // --- Initialization ---

    function initializeEventListeners() {
        if (!container) return;
        container.addEventListener('focusout', onFocusOutHandler);
        container.addEventListener('keydown', onKeyDownHandler);
    }


});


// --- Global Functions ---

function refocusInput(x) {
    console.log(x);
    clearInput();
    setTimeout(() => {
        const input = document.getElementById('barcodeInput');
        if (input) input.focus();
    }, 100); // Delay gives browser time to complete blur/focusout handling
}

function clearInput() {
    const input = document.getElementById('barcodeInput');
    if (input) input.value = "";
}
