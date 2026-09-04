document.addEventListener("DOMContentLoaded", function () {
   // ----- Category filter -----
   const filterButtons = document.querySelectorAll(".filter-btn");
   const menuCards = document.querySelectorAll(".menu-card");
   filterButtons.forEach(function (btn) {
       btn.addEventListener("click", function () {
           filterButtons.forEach(function (b) { b.classList.remove("active"); });
           btn.classList.add("active");
           const category = btn.dataset.category;
           menuCards.forEach(function (card) {
               if (category === "all" || card.dataset.category === category) {
                   card.style.display = "flex";
               } else {
                   card.style.display = "none";
               }
           });
       });
   });
   // ----- Modal open/close -----
   document.querySelectorAll(".details-btn").forEach(function (btn) {
       btn.addEventListener("click", function () {
           const modal = document.getElementById(btn.dataset.modalTarget);
           if (modal) modal.classList.add("active");
       });
   });
   document.querySelectorAll(".modal-overlay").forEach(function (overlay) {
       const closeBtn = overlay.querySelector("[data-modal-close]");
       if (closeBtn) {
           closeBtn.addEventListener("click", function () {
               overlay.classList.remove("active");
           });
       }
       overlay.addEventListener("click", function (e) {
           if (e.target === overlay) {
               overlay.classList.remove("active");
           }
       });
   });
   document.addEventListener("keydown", function (e) {
       if (e.key === "Escape") {
           document.querySelectorAll(".modal-overlay.active").forEach(function (overlay) {
               overlay.classList.remove("active");
           });
       }
   });
   // ----- Add-ons per category -----
   // No add-ons table in the DB - keyed by category instead, so a dessert
   // doesn't get offered "extra cheese." Format is "Name:price" (RM).
   const ADDONS_BY_CATEGORY = {
       "Starters": [
           { label: "Extra Parmesan", value: "Extra Parmesan:3.00" },
           { label: "Extra Truffle Oil", value: "Extra Truffle Oil:5.00" }
       ],
       "First course": [
           { label: "Extra Parmesan", value: "Extra Parmesan:3.00" },
           { label: "Extra Truffle Shavings", value: "Extra Truffle Shavings:8.00" }
       ],
       "Main course": [
           { label: "Extra Sauce", value: "Extra Sauce:2.00" },
           { label: "Side Salad", value: "Side Salad:6.00" }
       ],
       "Desserts": [
           { label: "Extra Berries", value: "Extra Berries:3.00" },
           { label: "Extra Scoop of Gelato", value: "Extra Scoop of Gelato:4.00" }
       ],
       "Wine and beverages": [
           { label: "Add Ice", value: "Add Ice:0.00" }
       ]
   };
   // ----- Toast -----
   function showToast(message, isError) {
       const toast = document.createElement("div");
       toast.textContent = message;
       toast.style.position = "fixed";
       toast.style.bottom = "24px";
       toast.style.right = "24px";
       toast.style.padding = "12px 20px";
       toast.style.borderRadius = "8px";
       toast.style.color = "#fff";
       toast.style.backgroundColor = isError ? "#c0392b" : "#198754";
       toast.style.boxShadow = "0 2px 10px rgba(0,0,0,0.2)";
       toast.style.zIndex = "9999";
       toast.style.opacity = "0";
       toast.style.transition = "opacity 0.25s ease";
       document.body.appendChild(toast);
       requestAnimationFrame(function () {
           toast.style.opacity = "1";
       });
       setTimeout(function () {
           toast.style.opacity = "0";
           setTimeout(function () { toast.remove(); }, 300);
       }, 2500);
   }
   // ----- Shared quantity + add-ons + add-to-cart wiring -----
   // Used for both the .menu-card grid and the .modal-overlay detail view,
   // since a modal is really just a second "view" of the same item.
   function setupItemContainer(container, idPrefix) {
       const qtyInput = container.querySelector(".qty-input");
       const decreaseBtn = container.querySelector('[data-action="decrease"]');
       const increaseBtn = container.querySelector('[data-action="increase"]');
       const addBtn = container.querySelector(".add-to-cart-btn");
       const nameEl = container.querySelector("h3");
       if (!qtyInput || !decreaseBtn || !increaseBtn || !addBtn || !nameEl) return;
       decreaseBtn.addEventListener("click", function () {
           let val = parseInt(qtyInput.value, 10);
           if (val > 1) qtyInput.value = val - 1;
       });
       increaseBtn.addEventListener("click", function () {
           let val = parseInt(qtyInput.value, 10);
           qtyInput.value = val + 1;
       });
       const itemId = addBtn.dataset.itemId;
       // Category: prefer data-category on this container. If it's a modal
       // that doesn't carry its own data-category, fall back to looking up
       // the matching .menu-card by item id.
       let category = container.dataset.category;
       if (!category && itemId) {
           const matchingBtn = document.querySelector(
               '.menu-card .add-to-cart-btn[data-item-id="' + itemId + '"]'
           );
           if (matchingBtn) {
               const matchingCard = matchingBtn.closest(".menu-card");
               if (matchingCard) category = matchingCard.dataset.category;
           }
       }
       // Insert add-ons checkboxes for this item's category, if any.
       const addons = ADDONS_BY_CATEGORY[category];
       if (addons && addons.length > 0) {
           const wrap = document.createElement("div");
           wrap.className = "item-addons";
           addons.forEach(function (addon, index) {
               const id = "addon-" + (idPrefix || itemId) + "-" + index;
               const label = document.createElement("label");
               label.setAttribute("for", id);
               label.style.display = "block";
               label.style.fontSize = "0.9rem";
               label.style.marginBottom = "0.25rem";
               const checkbox = document.createElement("input");
               checkbox.type = "checkbox";
               checkbox.id = id;
               checkbox.className = "addon-checkbox";
               checkbox.value = addon.value;
               checkbox.style.marginRight = "0.4rem";
               label.appendChild(checkbox);
               label.appendChild(document.createTextNode(addon.label));
               wrap.appendChild(label);
           });
           // Modals wrap qty + add-to-cart in .item-actions; cards use
           // .card-buttons for the button row instead - check both so the
           // add-ons block lands above the buttons in either layout.
           const actions = container.querySelector(".item-actions") || container.querySelector(".card-buttons");
           if (actions && actions.parentNode) {
               actions.parentNode.insertBefore(wrap, actions);
           } else {
               addBtn.parentNode.insertBefore(wrap, addBtn);
           }
       }
       // ----- Add to cart -----
       addBtn.addEventListener("click", function () {
           const name = nameEl.textContent.trim();
           const qty = qtyInput.value;
           // Read price from data-item-price (raw EL output, always uses a
           // period). Do NOT scrape the ".item-price" span text - that's
           // rendered with <fmt:formatNumber>, which formats using the
           // browser's language. In French, for example, "92.00" displays
           // as "92,00" - stripping non-digit characters would delete the
           // comma and turn it into "9200", inflating the price 100x.
           const price = parseFloat(addBtn.dataset.itemPrice);
           const selectedAddons = [];
           container.querySelectorAll(".addon-checkbox:checked").forEach(function (cb) {
               selectedAddons.push(cb.value);
           });
           const params = new URLSearchParams();
           params.append("foodId", itemId);
           params.append("foodName", name);
           params.append("price", price);
           params.append("quantity", qty);
           selectedAddons.forEach(function (a) { params.append("addons", a); });
           addBtn.disabled = true;
           fetch("AddToCart", {
               method: "POST",
               headers: { "X-Requested-With": "XMLHttpRequest" },
               body: params
           })
           .then(function (response) {
               return response.json().then(function (data) {
                   return { status: response.status, data: data };
               });
           })
           .then(function (result) {
               if (result.data.redirect) {
                   window.location.href = result.data.redirect;
                   return;
               }
               if (result.data.success) {
                   showToast(result.data.foodName + " added to cart!", false);
                   // If this was triggered from inside a modal, close it after adding
                   const parentModal = container.closest(".modal-overlay");
                   if (parentModal) parentModal.classList.remove("active");
               } else {
                   showToast(result.data.message || "Could not add item.", true);
               }
           })
           .catch(function () {
               showToast("Network error - please try again.", true);
           })
           .finally(function () {
               addBtn.disabled = false;
           });
       });
   }
   // Wire up quantity + add-ons + Add to Cart on every card
   document.querySelectorAll(".menu-card").forEach(function (card) {
       const addBtn = card.querySelector(".add-to-cart-btn");
       setupItemContainer(card, addBtn ? addBtn.dataset.itemId : null);
   });
   // Wire up quantity + add-ons + Add to Cart inside every modal
   document.querySelectorAll(".modal-overlay").forEach(function (modal) {
       const addBtn = modal.querySelector(".add-to-cart-btn");
       const prefix = addBtn ? "modal-" + addBtn.dataset.itemId : null;
       setupItemContainer(modal, prefix);
   });
});
