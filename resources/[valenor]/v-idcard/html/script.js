const mainContainer = document.querySelector('.main-container');
const mainContainer2 = document.querySelector('.main-container-2');
const signatureButton = document.querySelector('.signature-button');

const formInputs = mainContainer.querySelectorAll('.inputkemkum');
const cardInputs = mainContainer2.querySelectorAll('.inputkemkum');

let currentPhotoUrl = null;

window.addEventListener('message', function (event) {
    const data = event.data;

    switch (data.action) {
        case 'openCreationmenu':
            openCardCreationMenu(data);
            break;

        case 'showCard':
            showCardToPlayer(data);
            break;

        case 'updatePhoto':
            if (data.photoUrl) {
                currentPhotoUrl = data.photoUrl;
                const profilePhoto = mainContainer.querySelector('.profilephoto');
                if (profilePhoto) {
                    profilePhoto.style.backgroundImage = `url(${data.photoUrl})`;
                }
            }
            break;

        case 'closeUI':
            closeAllMenus();
            break;
    }
});

function openCardCreationMenu(data) {
    mainContainer2.style.display = 'none';
    mainContainer.style.display = 'flex';

    const profilePhoto = mainContainer.querySelector('.profilephoto');

    // Damga animasyonunu sıfırla (her yeni açılışta tekrar animasyon oynatılsın)
    const signatureBtn = mainContainer.querySelector('.signature-button');
    if (signatureBtn) {
        signatureBtn.classList.remove('stamped');
    }

    if (data.photoUrl && data.photoUrl.length > 0) {
        currentPhotoUrl = data.photoUrl;
        profilePhoto.style.backgroundImage = `url(${data.photoUrl})`;
        profilePhoto.classList.add('custom-photo');
    } else {
        currentPhotoUrl = null;
        profilePhoto.style.backgroundImage = 'url(img/pp.png)';
        profilePhoto.classList.remove('custom-photo');
    }

    if (data.data) {
        fillFormInputs(data.data);
        if (data.data.photoUrl && data.data.photoUrl.length > 0) {
            currentPhotoUrl = data.data.photoUrl;
            profilePhoto.style.backgroundImage = `url(${data.data.photoUrl})`;
            profilePhoto.classList.add('custom-photo');
        }
    } else {
        clearFormInputs();
    }

    setupPhotoModal();
}

function setupPhotoModal() {
    const profilePhoto = mainContainer.querySelector('.profilephoto');
    const inputContainer = document.querySelector('.input-container');
    const linkInput = inputContainer.querySelector('.linkinput');
    const confirmButton = inputContainer.querySelector('.confirmbutton');
    const cancelButton = inputContainer.querySelector('.cancelbutton');
    
    profilePhoto.onclick = function(e) {
        e.stopPropagation();
        inputContainer.style.display = 'flex';
        linkInput.value = currentPhotoUrl || '';
        linkInput.focus();
    };
    
    confirmButton.onclick = function() {
        const newUrl = linkInput.value.trim();
        
        if (newUrl && newUrl.startsWith('http')) {
            currentPhotoUrl = newUrl;
            profilePhoto.style.backgroundImage = `url(${newUrl})`;
            profilePhoto.classList.add('custom-photo');
        } else if (newUrl === '') {
            currentPhotoUrl = null;
            profilePhoto.style.backgroundImage = 'url(img/pp.png)';
            profilePhoto.classList.remove('custom-photo');
        }
        
        inputContainer.style.display = 'none';
        linkInput.value = '';
    };
    
    cancelButton.onclick = function() {
        inputContainer.style.display = 'none';
        linkInput.value = '';
    };
    
    linkInput.onkeydown = function(e) {
        if (e.key === 'Enter') {
            confirmButton.click();
        } else if (e.key === 'Escape') {
            cancelButton.click();
        }
    };
}

function showCardToPlayer(data) {
    mainContainer.style.display = 'none';
    mainContainer2.style.display = 'flex';

    fillCardInputs(data.cardData);

    const profilePhoto2 = mainContainer2.querySelector('.profilephoto-2');
    
    if (data.photoUrl && data.photoUrl.length > 0) {
        profilePhoto2.style.backgroundImage = `url(${data.photoUrl})`;
        profilePhoto2.classList.add('custom-photo');
    } else {
        profilePhoto2.style.backgroundImage = 'url(img/pplast.png)';
        profilePhoto2.classList.remove('custom-photo');
    }
}

function closeAllMenus() {
    mainContainer.style.display = 'none';
    mainContainer2.style.display = 'none';
}

function fillFormInputs(playerData) {
    const fields = [
        'fullname', 'dateOfBirth', 'bornIn', 'eyesColor', 'hairColor',
        'weight', 'height', 'gender', 'nationality', 'employed', 'residence', 'signature'
    ];

    fields.forEach((field, index) => {
        if (formInputs[index] && playerData[field]) {
            formInputs[index].value = playerData[field];
        }
    });
}

function fillCardInputs(cardData) {
    const fields = [
        'fullname', 'dateOfBirth', 'bornIn', 'eyesColor', 'hairColor',
        'weight', 'height', 'gender', 'nationality', 'employed', 'residence', 'signature',
        'registryNo', 'issueDate'
    ];

    fields.forEach((field, index) => {
        if (cardInputs[index] && cardData[field]) {
            cardInputs[index].value = cardData[field];
        }
    });
}

function clearFormInputs() {
    formInputs.forEach(input => {
        input.value = '';
    });
}

function collectFormData() {
    return {
        fullname: formInputs[0].value,
        dateOfBirth: formInputs[1].value,
        bornIn: formInputs[2].value,
        eyesColor: formInputs[3].value,
        hairColor: formInputs[4].value,
        weight: formInputs[5].value,
        height: formInputs[6].value,
        gender: formInputs[7].value,
        nationality: formInputs[8].value,
        employed: formInputs[9].value,
        residence: formInputs[10].value,
        signature: formInputs[11].value,
        photoUrl: currentPhotoUrl
    };
}

document.addEventListener('DOMContentLoaded', function () {
    const signatureBtn = document.querySelector('.signature-button');
    if (signatureBtn) {
        signatureBtn.addEventListener('click', function () {
            // Damga animasyonunu tetikle
            if (!signatureBtn.classList.contains('stamped')) {
                signatureBtn.classList.add('stamped');
            }

            const cardData = collectFormData();

            fetch(`https://${GetParentResourceName()}/saveCard`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify(cardData)
            });
        });
    }
});

document.addEventListener('keydown', function (event) {
    if (event.key === 'Escape' || event.keyCode === 27) {
        fetch(`https://${GetParentResourceName()}/closeUI`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({})
        });

        closeAllMenus();
    }
});

function GetParentResourceName() {
    const hostname = window.location.hostname;
    return hostname.replace('cfx-nui-', '');
}
