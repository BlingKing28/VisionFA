const helper = document.querySelector('#helper');
const form = document.querySelector('#tuto-form');

const yesButton = form.querySelector('#yes');
const noButton = form.querySelector('#no');

let currentStep = 0;

const steps = [
    {
        title: 'Téléphone',
        desc: 'Pour utiliser ton téléphone, appuie sur la touche <strong>W</strong>',
    },
    {
        title: 'Véhicule de location',
        desc: 'Récupère un véhicule pour pouvoir te déplacer',
    },
    {
        title: 'Permis de conduire',
        desc: 'Passe ton permis de conduire pour être en règle',
    },
    {
        title: 'Pièce d\'identité',
        desc: 'Récupère ta pièce d\'identité et ton permis au poste de police',
    },
    {
        title: 'Magasin de vêtements',
        desc: 'Rends-toi au binco pour te faire une tenue de travail',
    },
    {
        title: 'Épicerie',
        desc: 'Procure toi à boire et à manger au LTD le plus proche',
    },
    {
        title: 'Job Center',
        desc: 'Rends-toi au job center pour commencer à travailler',
    },
    {
        title: 'Tutotiel terminé',
        desc: 'Tu peux désormais jouer librement sur le serveur',
    }
]

const updateNotification = (title, desc, visible) => {
    helper.classList.remove('slideFromTop');
    helper.classList.add('slideToTop')
    setTimeout(() => {
        helper.querySelector('h2').innerText = title;
        helper.querySelector('p').innerHTML = desc;
        if (visible) {
            helper.classList.remove('slideToTop');
            helper.classList.add('slideFromTop');
        }
        helper.style.display = visible ? 'block' : 'none';
    }, 500);
}

const toggleForm = (visible) => {
    form.style.display = visible ? 'flex' : 'none';
}

const triggerNuiCallback = (action, data = {}) => {
    // Trigger NUI callback
    fetch(`http://${GetParentResourceName()}/${action}`, {
        method: 'POST',
        body: JSON.stringify(data),
        headers: {
            'Content-Type': 'application/json; charset=UTF-8',
        },
    });
}

yesButton.addEventListener('click', () => {
    toggleForm(false);
    triggerNuiCallback('disableFocus');
    triggerNuiCallback('startTuto');
    updateNotification(steps[0].title, steps[0].desc, true);
    setTimeout(() => {
        updateNotification(steps[1].title, steps[1].desc, true);
        currentStep = 1;
    }, 5000);
});

noButton.addEventListener('click', () => {
    toggleForm(false);
    triggerNuiCallback('disableFocus');
});

window.addEventListener('message', (event) => {
    switch (event.data.action) {
        case 'openForm':
            toggleForm(true);
            break;
        case 'gotoStep':
            if (steps[event.data.step]) {
                if (event.data.step !== currentStep + 1) {
                    return;
                }
                currentStep = event.data.step;
                updateNotification(steps[event.data.step].title, steps[event.data.step].desc, true);
                if (event.data.step === steps.length - 1) {
                    setTimeout(() => {
                        updateNotification("", "", false);
                    }, 5000);
                }
            }
            break;
    }
});