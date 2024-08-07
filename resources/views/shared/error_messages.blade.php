@if ($errors->any())
    <div class="alert alert-danger">
        <ul class="my-2">
            @foreach ($errors->all() as $error)
                <li class="text-red-600 ">{{ $error }}</li>
            @endforeach
        </ul>
    </div>
@endif
