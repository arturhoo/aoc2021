use std::collections::HashMap;

pub mod util;

#[derive(Debug)]
struct Lanternfish {
    timer: u8,
}

impl Lanternfish {
    fn process(&mut self) -> bool {
        self.timer = self.timer.wrapping_sub(1);
        if self.timer == u8::MAX {
            self.timer = 6;
            return true;
        }
        false
    }
}

pub fn p1(input: &Vec<String>, days: i32) -> usize {
    let mut fishes: Vec<Lanternfish> = input[0]
        .split(",")
        .map(|token| Lanternfish {
            timer: token.parse().unwrap(),
        })
        .collect();
    for _ in 0..days {
        for i in 0..fishes.len() {
            let should_produce = fishes[i].process();
            if should_produce {
                let new_fish = Lanternfish { timer: 8 };
                fishes.push(new_fish);
            }
        }
    }
    fishes.len()
}

pub fn p2(input: &Vec<String>, days: usize) -> usize {
    let numbers: Vec<u8> = input[0].split(",").map(|t| t.parse().unwrap()).collect();
    let mut cnt: usize = 0;
    let mut memory: HashMap<usize, usize> = HashMap::new();
    for num in &numbers {
        cnt += calculate_for_single_fish(*num, days, &mut memory);
    }
    cnt + numbers.len()
}

fn calculate_for_single_fish(
    timer: u8,
    days_left: usize,
    memory: &mut HashMap<usize, usize>,
) -> usize {
    // Normalize the fish as if its timer was at 8
    let mut new_days_left = days_left;
    if timer <= 8 {
        new_days_left = (8 - timer as usize) + days_left;
    }

    let result = calculate_when_timer_at_8(new_days_left, memory);
    result
}

fn calculate_when_timer_at_8(days_left: usize, memory: &mut HashMap<usize, usize>) -> usize {
    if days_left <= 8 {
        return 0;
    } else if memory.contains_key(&days_left) {
        return memory[&days_left];
    }

    let directly_generated: usize = ((days_left - 2) / 7).try_into().unwrap();
    let mut cnt = directly_generated;
    for i in 0..directly_generated {
        cnt += calculate_when_timer_at_8(days_left - 9 - 7 * i, memory);
    }
    memory.insert(days_left, cnt);
    cnt
}
