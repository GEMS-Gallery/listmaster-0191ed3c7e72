import { backend } from 'declarations/backend';

const shoppingList = document.getElementById('shopping-list');
const addItemForm = document.getElementById('add-item-form');
const newItemInput = document.getElementById('new-item');

async function loadItems() {
    const items = await backend.getItems();
    shoppingList.innerHTML = '';
    items.forEach(item => {
        const li = document.createElement('li');
        li.innerHTML = `
            <span>${item.description}</span>
            <button class="delete-btn"><i class="fas fa-trash"></i></button>
        `;
        li.dataset.id = item.id;
        if (item.completed) {
            li.classList.add('completed');
        }
        li.addEventListener('click', toggleItem);
        li.querySelector('.delete-btn').addEventListener('click', deleteItem);
        shoppingList.appendChild(li);
    });
}

async function addItem(e) {
    e.preventDefault();
    const description = newItemInput.value.trim();
    if (description) {
        await backend.addItem(description);
        newItemInput.value = '';
        await loadItems();
    }
}

async function toggleItem(e) {
    if (e.target.tagName === 'BUTTON') return;
    const id = parseInt(this.dataset.id);
    await backend.toggleItem(id);
    await loadItems();
}

async function deleteItem(e) {
    e.stopPropagation();
    const id = parseInt(this.parentElement.dataset.id);
    await backend.deleteItem(id);
    await loadItems();
}

addItemForm.addEventListener('submit', addItem);

// Initial load
loadItems();