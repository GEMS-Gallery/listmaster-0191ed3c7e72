import { backend } from 'declarations/backend';

const shoppingList = document.getElementById('shopping-list');
const addItemForm = document.getElementById('add-item-form');
const newItemInput = document.getElementById('new-item');
const predefinedProductsContainer = document.getElementById('predefined-products');

async function loadItems() {
    const items = await backend.getItems();
    shoppingList.innerHTML = '';
    items.forEach(item => {
        const li = document.createElement('li');
        li.innerHTML = `
            <span><span class="emoji">${item.emoji}</span>${item.description}</span>
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
        await backend.addItem(description, "🛒");
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

async function loadPredefinedProducts() {
    const products = await backend.getPredefinedProducts();
    predefinedProductsContainer.innerHTML = '';
    
    const groupedProducts = products.reduce((acc, product) => {
        if (!acc[product.category]) {
            acc[product.category] = [];
        }
        acc[product.category].push(product);
        return acc;
    }, {});

    Object.entries(groupedProducts).forEach(([category, products]) => {
        const categoryDiv = document.createElement('div');
        categoryDiv.className = 'product-category';
        categoryDiv.innerHTML = `<h2>${category}</h2>`;
        
        const productList = document.createElement('div');
        productList.className = 'product-list';
        
        products.forEach(product => {
            const button = document.createElement('button');
            button.innerHTML = `<span class="emoji">${product.emoji}</span>${product.name}`;
            button.addEventListener('click', () => quickAddItem(product.name, product.emoji));
            productList.appendChild(button);
        });
        
        categoryDiv.appendChild(productList);
        predefinedProductsContainer.appendChild(categoryDiv);
    });
}

async function quickAddItem(name, emoji) {
    await backend.addItem(name, emoji);
    await loadItems();
}

addItemForm.addEventListener('submit', addItem);

// Initial load
loadItems();
loadPredefinedProducts();