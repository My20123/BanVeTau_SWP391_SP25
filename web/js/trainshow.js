/* Fixed and optimized version of trainshow.js */

// Form validation
function validateForm() {
    const fromStationElem = document.getElementById('from_station');
    const toStationElem = document.getElementById('to_station');
    const departDateElem = document.getElementById('datepicker');
    const returnDateElem = document.getElementById('return_datepicker');

    if (!fromStationElem || !toStationElem || !departDateElem) {
        alert('Có lỗi xảy ra: Một số trường không tìm thấy trên trang.');
        return false;
    }

    const fromStation = fromStationElem.value.trim();
    const toStation = toStationElem.value.trim();
    const departDate = departDateElem.value;
    const returnDate = returnDateElem ? returnDateElem.value : '';

    if (!fromStation || !toStation) {
        alert('Vui lòng chọn ga đi và ga đến.');
        return false;
    }

    if (fromStation === toStation) {
        alert('Ga đi và ga đến không được trùng nhau.');
        return false;
    }

    const today = new Date();
    today.setHours(0, 0, 0, 0);
    const depart = new Date(departDate);

    if (depart < today) {
        alert('Ngày đi không thể là ngày trong quá khứ.');
        return false;
    }

    if (returnDate) {
        const returnD = new Date(returnDate);
        if (returnD < depart) {
            alert('Ngày về phải sau ngày đi.');
            return false;
        }
    }
    return true;
}

// Swap station values
function swapData() {
    const fromStationElem = document.getElementById('from_station');
    const toStationElem = document.getElementById('to_station');
    
    if (fromStationElem && toStationElem) {
        [fromStationElem.value, toStationElem.value] = [toStationElem.value, fromStationElem.value];
    }
}

// Set min date for datepickers
window.onload = function() {
    const today = new Date().toISOString().split('T')[0];
    const departPicker = document.getElementById('datepicker');
    const returnPicker = document.getElementById('return_datepicker');
    
    if (departPicker) departPicker.min = today;
    if (returnPicker) returnPicker.min = today;
    
    if (departPicker && returnPicker) {
        departPicker.addEventListener('change', function() {
            returnPicker.min = this.value;
        });
    }

    // Auto-select the first train on page load
    const firstTrain = document.querySelector('.et-train-block');
    if (firstTrain) {
        const firstTrainHead = firstTrain.querySelector('.et-train-head');
        if (firstTrainHead) {
            selectTrain(firstTrain.getAttribute('data-train-id'), firstTrainHead);
        }
    }
};

// Function to show corresponding cabin list when train is selected
function selectTrain(trainId, trainHead, isInitialLoad = false) {
    if (!trainId || !trainHead) return;

    // Cập nhật trạng thái chọn tàu
    document.querySelectorAll('.et-train-head').forEach(h => h.classList.remove('et-train-head-selected'));
    trainHead.classList.add('et-train-head-selected');

    // Cập nhật URL nhưng không đẩy history nếu là load lần đầu
    const currentUrl = new URL(window.location.href);
    currentUrl.searchParams.set('trainId', trainId);
    if (!isInitialLoad) {
        history.pushState({}, '', currentUrl.toString());
    }

    // Ẩn tất cả cabin
    document.querySelectorAll('.col-md-12.et-no-margin').forEach(container => {
        container.style.display = 'none';
    });

    // Hiển thị cabin của train được chọn
    const selectedCabinContainer = document.getElementById(`cabin-container-${trainId}`);
    if (selectedCabinContainer) {
        selectedCabinContainer.style.display = 'block';
    }
}

// Lắng nghe sự kiện click trên trainHead
document.addEventListener('DOMContentLoaded', function () {
    document.querySelectorAll('.et-train-head').forEach(trainHead => {
        trainHead.addEventListener('click', function () {
            selectTrain(this.getAttribute('data-train-id'), this);
        });
    });
});


// Function to select cabin
function selectCabin(cabinId, carIcon) {
    if (!cabinId || !carIcon) return;
    
    document.querySelectorAll('.et-car-icon').forEach(icon => icon.classList.remove('et-car-icon-selected'));
    carIcon.classList.add('et-car-icon-selected');
    
    const currentUrl = new URL(window.location.href);
    currentUrl.searchParams.set('cabinId', cabinId);
    history.pushState({}, '', currentUrl.toString());
}

// Function to select seat
function selectSeat(element, seatNumber, price, trainType, carNumber) {
    const seatSpan = element.querySelector('.ng-binding');
    const actualSeatNumber = seatSpan ? seatSpan.textContent : seatNumber;
    const formattedPrice = Number(price).toLocaleString('vi-VN');
    
    const cartItem = `
        <div class="cart-item">
            <p><strong>Số ghế:</strong> ${actualSeatNumber}</p>
            <p><strong>Loại tàu:</strong> ${trainType}</p>
            <p><strong>Toa số:</strong> ${carNumber}</p>
            <p><strong>Giá:</strong> ${formattedPrice} VNĐ</p>
        </div>
    `;
    
    const cart = document.getElementById('selectedSeats');
    if (cart) {
        cart.innerHTML = cartItem;
    }
    
    const orderForm = document.getElementById('orderForm');
    if (orderForm) {
        orderForm.style.display = 'block';
        const seatInfo = {
            seatNumber: actualSeatNumber,
            trainType: trainType,
            carNumber: carNumber,
            price: price
        };
        document.getElementById('seatInfo').value = JSON.stringify(seatInfo);
    }
    
    document.querySelectorAll('.et-car-seat-left').forEach(seat => {
        seat.classList.remove('selected-seat');
    });
    element.classList.add('selected-seat');
    
    fetch('UpdateSeatSession', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify(seatInfo)
    })
    .then(response => response.json())
    .then(data => {
        if (!data.success) {
            console.error('Failed to update seat session');
        }
    })
    .catch(error => console.error('Error:', error));
}