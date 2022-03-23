@group(0)
@binding(0)
var<storage, read_write> v_indices: array<u32>; // this is used as both input and output for convenience

@group(1)
@binding(0)
var<storage, read_write> lots_of_data: array<u32>;

@stage(compute)
@workgroup_size(1)
fn main(@builtin(global_invocation_id) global_id: vec3<u32>) {
    if (global_id.x >= arrayLength(&v_indices)) {
        return;
    }

    var result: u32 = 0u;
    var i: u32 = 0u;
    loop {
        if (i >= arrayLength(&lots_of_data)) {
            break;
        }

        var a: u32 = lots_of_data[i];
        result = max(result, a);
        lots_of_data[i] = result;

        continuing {
            i += 1u;
        }
    }

    v_indices[global_id.x] = 123u;
}
