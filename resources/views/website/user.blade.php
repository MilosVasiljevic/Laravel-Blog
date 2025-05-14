@extends('layouts.website')
@section('content')    

    
    <div class="site-section bg-light">
      <div class="container">
        <div class="row">
          <div class="col-md-12">

                <p><img src="{{ asset($user->image) }}" alt="User Image" width="300"></p>
                  <p>{{ $user->name }}</p>
                  <p>{{ $user->email }}</p>
                  <p>{{ $user->description }}</p>

          </div>

        </div>
      </div>
    </div>
@endsection